using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Wordprocessing;
using DW = DocumentFormat.OpenXml.Drawing.Wordprocessing;
using PIC = DocumentFormat.OpenXml.Drawing.Pictures;
using DRW = DocumentFormat.OpenXml.Drawing;
using System.IO;
using System.Text.RegularExpressions;

namespace WordTemplateEngine
{
    public static class Utility
    {
        public static string GenerateDocument(string templateName, List<KeyValuePair<string, string>> directData, int nasBroj, int userId)
        {
            try
            {
                string templatePath = AppDomain.CurrentDomain.BaseDirectory + "Templates\\" + templateName;

                LoggerUtility.Logger.LogMessage("debug", templatePath);

                List<TagNameValuePair> data = new List<TagNameValuePair>();
                IEnumerable<Text> textsMain = null;
                List<DRW.Text> textsObjectsList = null;
                List<TextWithLocation> textsAll = new List<TextWithLocation>();

                string newFilePath = "";
                WordprocessingDocument wordDoc = null;

                Task[] tasks = new Task[] {
                    Task.Factory.StartNew(() => {
                        // Thread 1 begin                
                        foreach (KeyValuePair<string, string> kvp in directData)
                        {
                            TagNameValuePair tnvp = new TagNameValuePair();
                            tnvp.TagName = "{" + kvp.Key.TrimStart('{').TrimEnd('}').ToLower().Replace(" ", "") + "}";
                            tnvp.TagValue = kvp.Value;
                            data.Add(tnvp);
                        }
                        // Thread 1 end
                    }),
                    Task.Factory.StartNew(() => {
                        try {
                        // Thread 2 begin
                        newFilePath = PrepareDocument(templatePath, userId);

                        // Open template document
                        wordDoc = WordprocessingDocument.Open(newFilePath, true);

                        //List<TextWithLocation> textsHeaders = null;
                        //List<TextWithLocation> textsFooters = null;

                        Task[] tasksAccessDocument = new Task[] {
                            Task.Factory.StartNew(() => {
                                // Get texts from main document part.
                                textsMain = wordDoc.MainDocumentPart.Document.Body.Descendants<Text>();
                                SeparateTags(ref textsMain);
                                FixBrokenTags(ref textsMain);

                                List<Text> listTexts = textsMain.ToList<Text>();
                                textsAll.AddRange((from t in listTexts
                                                   where t.Text.StartsWith("{") && t.Text.EndsWith("}")
                                                   select new TextWithLocation(t, TagLocation.Main)).ToList<TextWithLocation>());

                            }),
                            //Task.Factory.StartNew(() => {
                            //    // Get texts from headers.
                            //    textsHeaders = new List<TextWithLocation>();
                            //    GetTextsHeaders(ref textsHeaders);
                            //    textsAll.AddRange(textsHeaders);
                            //}),
                            //Task.Factory.StartNew(() => {
                            //    // Get texts from footers.
                            //    textsFooters = new List<TextWithLocation>();
                            //    GetTextsFooters(ref textsFooters);
                            //    textsAll.AddRange(textsFooters);
                            //}),
                            //Task.Factory.StartNew(() => {
                            //    // Get texts from objects.
                            //    textsObjectsList = new List<DRW.Text>();
                            //    GetTextsObjects(ref textsObjectsList);
                            //})
                        };

                        Task.WaitAll(tasksAccessDocument);

                            // Thread 2 end
                        }
                        catch(Exception ex)
                        {
                            LoggerUtility.Logger.LogException(ex, "GenerateDocument");
                        }
                    })
                };

                Task.WaitAll(tasks);

                IEnumerable<TextWithLocation> texts = textsAll;
                IEnumerable<DRW.Text> textsObjects = textsObjectsList;

                //data = (from d in data
                //        where d.TagName.StartsWith("{")
                //        select d).ToList<TagNameValuePair>();

                for (int i = 0; i < data.Count(); i++)
                {
                    TagNameValuePair tnvp = data[i];
                    var tokenTexts = texts.Where(t => t.TextTag.Text.IndexOf(tnvp.TagName) >= 0);
                    //var objectTokenTexts = textsObjects.Where(t => t.InnerText.IndexOf(tnvp.TagName) >= 0);

                    string tagStartsWith = tnvp.TagName.Substring(0, 5);
                    ReplaceTag_Text(ref tokenTexts, tnvp); // main part, header, footer
                    //ReplaceTag_Text_Object(ref objectTokenTexts, tnvp); // other objects in document
                }

                //string fileName = template.Name + " (" + new UserProvider().GetById(userId).Username + ")" + ".docx";
                //string fileName = templateName + " (EMIR)" + ".docx";

                wordDoc.MainDocumentPart.Document.Save();
                wordDoc.Close();

                string fileName = newFilePath.Substring(newFilePath.LastIndexOf('\\') + 1);
                string downloadFileName = templateName.Replace(".docx", "") + " (" + nasBroj.ToString() + ")" + ".docx";
                string downloadFilePath = newFilePath.Replace(fileName, downloadFileName);

                if (File.Exists(downloadFilePath))
                    File.Delete(downloadFilePath);

                File.Move(newFilePath, downloadFilePath);
                return downloadFileName;
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        #region Private methods
        private static string PrepareDocument(string templatePath, int userId)
        {
            string folderPath = AppDomain.CurrentDomain.BaseDirectory + "Temp\\" + userId.ToString() + "\\";
            if (Directory.Exists(folderPath))
                Directory.Delete(folderPath, true);
            Directory.CreateDirectory(folderPath);

            string newFilePath = folderPath + Guid.NewGuid().ToString("N");
            File.Copy(templatePath, newFilePath);
            return newFilePath;
        }

        /// <summary>
        /// Joins tags broken into pieces back together.
        /// </summary>
        /// <param name="texts"></param>
        private static void FixBrokenTags(ref IEnumerable<Text> texts)
        {
            List<Text> listTexts = texts.ToList<Text>();

            List<int> beginningIndexes = (from t in listTexts
                                          where t.Text.StartsWith("{")
                                          select listTexts.IndexOf(t)).ToList<int>();

            List<int> endingIndexes = (from t in listTexts
                                       where t.Text.EndsWith("}")
                                       select listTexts.IndexOf(t)).ToList<int>();

            Parallel.For(0, beginningIndexes.Count, i =>
            {
                string fixedTag = string.Join("", (from t in (listTexts.Where((t, index) => (index >= beginningIndexes[i] && index <= endingIndexes[i])))
                                                   select t.Text).ToArray());

                listTexts.Where((t, index) => (index >= beginningIndexes[i] + 1 && index <= endingIndexes[i])).ToList().ForEach(u => u.Text = "");

                listTexts.ElementAt(beginningIndexes[i]).Text = fixedTag;
            });

        }

        /// <summary>
        /// Separates tags so that "{" is allways at the beginning and that "}" is always at the end of individual string.
        /// Normal text tags (without "{" or "}") stay unchanged.
        /// </summary>
        /// <param name="wordDoc"></param>
        /// <param name="texts"></param>
        /// <returns></returns>
        private static void SeparateTags(ref IEnumerable<Text> texts)
        {
            for (int i = 0; i < texts.Count(); i++)
            {
                string tempText = texts.ElementAt<Text>(i).Text.Trim(); // optimizing

                if (tempText.IndexOf("{") >= 0)
                {
                    texts.ElementAt<Text>(i).Text = tempText;

                    // If "{" exists multiple times, separate them.
                    int countOpenings = tempText.Split('{').Length - 1;
                    if (countOpenings > 1)
                    {
                        int lastIndexOfOpen = tempText.LastIndexOf("{");
                        AddTextAfter(ref texts, i, tempText.Substring(lastIndexOfOpen));
                        tempText = tempText.Substring(0, lastIndexOfOpen);
                        texts.ElementAt<Text>(i).Text = tempText;
                    }

                    // If "{" is not at the beginning of string, separate.
                    int indexOpen = tempText.IndexOf("{");
                    if (indexOpen > 0)
                    {
                        AddTextBefore(ref texts, i, tempText.Substring(0, indexOpen).Trim());
                        string tempTextNext = texts.ElementAt<Text>(i + 1).Text; // optimizing
                        texts.ElementAt<Text>(i + 1).Text = tempTextNext.Replace(tempText.Substring(0, indexOpen), "").Trim();
                        tempText = texts.ElementAt<Text>(i + 1).Text;
                    }
                }

                if (tempText.IndexOf("}") >= 0)
                {
                    // If "}" exists multiple times, separate them.
                    int countClosings = tempText.Split('}').Length - 1;
                    if (countClosings > 1)
                    {
                        int lastIndexOfOpen = tempText.LastIndexOf("{");
                        AddTextAfter(ref texts, i, tempText.Substring(lastIndexOfOpen));
                        tempText = tempText.Substring(0, lastIndexOfOpen);
                        texts.ElementAt<Text>(i).Text = tempText;
                    }

                    // If "}" is not at the end of string, separate.
                    int indexClose = tempText.IndexOf("}");
                    if (indexClose + 1 < tempText.Length)
                    {
                        AddTextAfter(ref texts, i, tempText.Substring(indexClose + 1));
                        tempText = tempText.TrimEnd();
                        texts.ElementAt<Text>(i).Text = tempText;
                    }
                }
            }
        }

        /// <summary>
        /// Inserts text tag before referent index.
        /// </summary>
        /// <param name="wordDoc"></param>
        /// <param name="texts"></param>
        /// <param name="referentIndex"> Index before which the new text tag is inserted. </param>
        /// <param name="textToInsert"> Text to insert in new tag. </param>
        private static void AddTextBefore(ref IEnumerable<Text> texts, int referentIndex, string textToInsert)
        {
            var lines = Regex.Split(textToInsert, "\r\n|\r|\n");

            var parent = texts.ElementAt<Text>(referentIndex).Parent;
            var newToken = texts.ElementAt<Text>(referentIndex).CloneNode(true);

            ((Text)newToken).Text = lines[0];
            ((Text)newToken).Space = SpaceProcessingModeValues.Preserve;

            for (int i = 1; i < lines.Length; i++)
            {
                parent.AppendChild<Break>(new Break());
                parent.AppendChild<Text>(new Text(lines[i]));
            }

            texts.ElementAt<Text>(referentIndex).InsertBeforeSelf(newToken);
        }

        /// <summary>
        /// Inserts text tag after referent index.
        /// </summary>
        /// <param name="wordDoc"></param>
        /// <param name="texts"></param>
        /// <param name="referentIndex"> Index after which the new text tag is inserted. </param>
        /// <param name="textToInsert"> Text to insert in new tag. </param>
        private static void AddTextAfter(ref IEnumerable<Text> texts, int referentIndex, string textToInsert)
        {
            var lines = Regex.Split(textToInsert, "\r\n|\r|\n");

            var parent = texts.ElementAt<Text>(referentIndex).Parent;
            var newToken = texts.ElementAt<Text>(referentIndex).CloneNode(true);

            ((Text)newToken).Text = lines[0];
            ((Text)newToken).Space = SpaceProcessingModeValues.Preserve;

            for (int i = 1; i < lines.Length; i++)
            {
                parent.AppendChild<Break>(new Break());
                parent.AppendChild<Text>(new Text(lines[i]));
            }

            texts.ElementAt<Text>(referentIndex).InsertAfterSelf(newToken);
        }

        private static void ReplaceTag_Text(ref IEnumerable<TextWithLocation> tokenTexts, TagNameValuePair tnvp)
        {
            if (tnvp.TagValue.Contains("\n")) // if text contains new lines
            {
                string[] tagValueParts = tnvp.TagValue.Split('\n');
                foreach (var token in tokenTexts)
                {
                    // Add first part of text to the original Text node.
                    token.TextTag.Text = tagValueParts[0];

                    for (int i = 1; i < tagValueParts.Length; i++)
                    {
                        // Add line break before every text part except the first one, i.e. the places where \n was in the original string: tnvp.TagValue.
                        token.TextTag.Parent.AppendChild(new Break());

                        // Create new Text nodes for all parts of text except the first one.
                        Text newTextNode = (Text)token.TextTag.CloneNode(true);
                        newTextNode.Text = tagValueParts[i];
                        token.TextTag.Parent.AppendChild(newTextNode);
                    }
                }
            }
            else
            {
                foreach (var token in tokenTexts)
                    token.TextTag.Text = tnvp.TagValue;
            }
        }

        private static void ReplaceTag_Text_Object(ref IEnumerable<DRW.Text> objectTokenTexts, TagNameValuePair tnvp)
        {
            foreach (var token in objectTokenTexts)
                if (token.InnerText.IndexOf(tnvp.TagName) >= 0)
                    token.Text = token.Text.Replace(tnvp.TagName, tnvp.TagValue);
        }

        #endregion
    }

    #region Helper classes

    public class TagNameValuePair
    {
        public string TagName { get; set; }
        public string TagValue { get; set; }

        public TagNameValuePair()
        {
            TagName = string.Empty;
            TagValue = string.Empty;
        }
    }

    public class TextWithLocation
    {
        public Text TextTag { get; set; }
        public TagLocation Location { get; set; }

        public HeaderPart HeaderPart { get; set; }
        public FooterPart FooterPart { get; set; }

        public int HeaderPartIndex { get; set; }
        public int FooterPartIndex { get; set; }

        public TextWithLocation()
        {
            this.TextTag = null;
            this.Location = TagLocation.Null;
            this.HeaderPart = null;
            this.FooterPart = null;
            this.HeaderPartIndex = -1;
            this.FooterPartIndex = -1;
        }

        public TextWithLocation(Text textTag, TagLocation location)
        {
            this.TextTag = textTag;
            this.Location = location;
            this.HeaderPart = null;
            this.FooterPart = null;
            this.HeaderPartIndex = -1;
            this.FooterPartIndex = -1;
        }

        public TextWithLocation(Text textTag, TagLocation location, HeaderPart headerPart, int headerPartIndex)
        {
            this.TextTag = textTag;
            this.Location = location;
            this.HeaderPart = headerPart;
            this.FooterPart = null;
            this.HeaderPartIndex = headerPartIndex;
            this.FooterPartIndex = -1;
        }

        public TextWithLocation(Text textTag, TagLocation location, FooterPart footerPart, int footerPartIndex)
        {
            this.TextTag = textTag;
            this.Location = location;
            this.HeaderPart = null;
            this.FooterPart = footerPart;
            this.HeaderPartIndex = -1;
            this.FooterPartIndex = footerPartIndex;
        }
    }

    public enum TagLocation
    {
        Null = 0,
        Main = 1,
        Header = 2,
        Footer = 3
    }

    #endregion
}
