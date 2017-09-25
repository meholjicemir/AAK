using NPOI.HSSF.UserModel;
using NPOI.SS.UserModel;
using NPOI.XSSF.UserModel;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace ExporterUtility
{
    public class Excel
    {
        public static void DataTable_To_Excel(string pFilePath, DataTable pDatos, string strSheetName, int userId,
            ref Dictionary<string, string> columnNameTranslations, string strHead = "", string strColumnRemove = "")
        {
            string[] strColumns = new string[1000];
            strColumnRemove = strColumnRemove.Trim(',');

            if (strColumnRemove != "")
                strColumns = strColumnRemove.ToLower().Split(',');

            pFilePath = Path.GetFileName(pFilePath);
            string folderPath = AppDomain.CurrentDomain.BaseDirectory + "Temp\\" + userId.ToString() + "\\";
            if (Directory.Exists(folderPath))
                Directory.Delete(folderPath, true);
            Directory.CreateDirectory(folderPath);

            pFilePath = folderPath + pFilePath;

            string strExt = Path.GetExtension(pFilePath);

            if (pDatos.Columns.Count > 250 && strExt == ".xls")
                throw new Exception("Please Export using NPOI XLSX..!!");

            if (strColumnRemove != "")
                strColumns = strColumnRemove.ToLower().Split(',');

            IWorkbook workbook = null;
            ISheet worksheet = null;
            int iRow = 0;
            try
            {
                if (pDatos != null && pDatos.Rows.Count > 0)
                {
                    using (FileStream stream = new FileStream(pFilePath, FileMode.Create, FileAccess.ReadWrite))
                    {
                        string ext = System.IO.Path.GetExtension(pFilePath);
                        switch (ext.ToLower())
                        {
                            case ".xls":
                                HSSFWorkbook workbookH = new HSSFWorkbook();
                                NPOI.HPSF.DocumentSummaryInformation dsi = NPOI.HPSF.PropertySetFactory.CreateDocumentSummaryInformation();
                                dsi.Company = "EMDEV";
                                dsi.Manager = "Emir Meholjic";
                                workbookH.DocumentSummaryInformation = dsi;
                                workbook = workbookH;
                                break;

                            case ".xlsx":
                                workbook = new XSSFWorkbook();
                                break;
                        }

                        worksheet = workbook.CreateSheet(strSheetName);
                        //worksheet.ProtectSheet("Password");
                        IFont font2;
                        font2 = workbook.CreateFont();
                        font2.FontHeightInPoints = 9;
                        font2.FontName = "Verdana";
                        font2.Boldweight = (short)FontBoldWeight.Normal;

                        IFont fontBold;
                        fontBold = workbook.CreateFont();
                        fontBold.FontHeightInPoints = 10;
                        fontBold.FontName = "Verdana";
                        fontBold.IsBold = true;
                        fontBold.IsItalic = true;
                        fontBold.Boldweight = (short)FontBoldWeight.Bold;

                        ICellStyle doubleCellStyle = workbook.CreateCellStyle();
                        doubleCellStyle.DataFormat = workbook.CreateDataFormat().GetFormat("#,##0.###");
                        doubleCellStyle.SetFont(font2);

                        ICellStyle intCellStyle = workbook.CreateCellStyle();
                        intCellStyle.DataFormat = workbook.CreateDataFormat().GetFormat("#,##0");
                        intCellStyle.SetFont(font2);

                        ICellStyle dateCellStyle = workbook.CreateCellStyle();
                        dateCellStyle.DataFormat = workbook.CreateDataFormat().GetFormat("MM-dd-yyyy");
                        dateCellStyle.SetFont(font2);

                        ICellStyle dateTimeCellStyle = workbook.CreateCellStyle();
                        dateTimeCellStyle.DataFormat = workbook.CreateDataFormat().GetFormat("MM-dd-yyyy HH:mm:ss");
                        dateTimeCellStyle.SetFont(font2);

                        ICellStyle stringCellStyle = workbook.CreateCellStyle();

                        intCellStyle.SetFont(font2);

                        IFont font1;
                        font1 = workbook.CreateFont();
                        font1.FontHeightInPoints = 9;
                        font1.FontName = "Verdana";
                        font1.Boldweight = (short)FontBoldWeight.Bold;

                        if (strHead != "")
                        {
                            int intColumnCount = pDatos.Columns.Count;
                            IRow row1 = worksheet.CreateRow(0);
                            ICell r1c1 = row1.CreateCell(0);
                            r1c1.SetCellValue(strHead);
                            r1c1.CellStyle.SetFont(fontBold);
                            r1c1.CellStyle.Alignment = HorizontalAlignment.Center;

                            //r1c1.CellStyle = red10;
                            r1c1.CellStyle.WrapText = true;
                            r1c1.Row.Height = 500;
                            NPOI.SS.Util.CellRangeAddress cra = new NPOI.SS.Util.CellRangeAddress(0, 0, 0, intColumnCount - 1);
                            worksheet.AddMergedRegion(cra);
                            iRow++;
                        }

                        if (pDatos.Columns.Count > 0)
                        {
                            int iCol = 0;
                            IRow fila = worksheet.CreateRow(iRow);
                            foreach (DataColumn columna in pDatos.Columns)
                            {
                                var target = columna.ColumnName.ToString().ToLower();
                                if (Array.IndexOf(strColumns, target) == -1)
                                {
                                    ICell cellHead = fila.CreateCell(iCol, CellType.String);
                                    cellHead.CellStyle.SetFont(font1);

                                    string columnName = columnNameTranslations.ContainsKey(columna.ColumnName) ? columnNameTranslations[columna.ColumnName] : columna.ColumnName;
                                    cellHead.SetCellValue(columnName);
                                    //worksheet.AutoSizeColumn(cellHead.ColumnIndex);
                                    iCol++;
                                }
                            }
                            iRow++;
                        }

                        GC.Collect();
                        GC.WaitForPendingFinalizers();

                        foreach (DataRow row in pDatos.Rows)
                        {
                            IRow fila = worksheet.CreateRow(iRow);
                            int iCol = 0;
                            int maxLength = 32767;
                            foreach (DataColumn column in pDatos.Columns)
                            {
                                var target = column.ColumnName.ToString().ToLower();
                                if (Array.IndexOf(strColumns, target) == -1)
                                {
                                    ICell cell = null;
                                    object cellValue = row[column.ColumnName];

                                    switch (column.DataType.ToString())
                                    {
                                        case "System.Boolean":
                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                cell = fila.CreateCell(iCol, CellType.Boolean);

                                                if (Convert.ToBoolean(cellValue)) { cell.SetCellFormula("TRUE()"); }
                                                else { cell.SetCellFormula("FALSE()"); }
                                            }
                                            break;
                                        case "System.String":

                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.CellStyle = stringCellStyle;
                                                cell.SetCellValue(Convert.ToString(cellValue.ToString().Length <= maxLength ? cellValue.ToString() : cellValue.ToString().Substring(0, maxLength)));
                                            }
                                            break;
                                        case "System.Int32":
                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                Regex regx = new Regex("[^0-9]");
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.SetCellValue(regx.Replace(cellValue.ToString(), ""));
                                                cell.CellStyle = intCellStyle;

                                            }
                                            break;
                                        case "System.Int64":
                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                Regex regx = new Regex("[^0-9]");
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.SetCellValue(regx.Replace(cellValue.ToString(), ""));
                                                cell.CellStyle = intCellStyle;
                                            }
                                            break;
                                        case "System.TimeSpan":

                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.CellStyle = stringCellStyle;
                                                cell.SetCellValue(Convert.ToString(cellValue.ToString().Length <= maxLength ? cellValue.ToString() : cellValue.ToString().Substring(0, maxLength)));
                                            }
                                            break;
                                        case "System.Decimal":
                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.SetCellValue(Convert.ToDouble(cellValue));
                                                cell.CellStyle = doubleCellStyle;
                                            }
                                            break;
                                        case "System.Double":
                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.SetCellValue(Convert.ToDouble(cellValue));
                                                cell.CellStyle = doubleCellStyle;
                                            }
                                            break;
                                        case "System.DateTime":
                                            if (cellValue != DBNull.Value && cellValue.ToString() != "")
                                            {
                                                cell = fila.CreateCell(iCol, CellType.String);
                                                cell.SetCellValue(Convert.ToDateTime(cellValue));
                                                DateTime cDate = Convert.ToDateTime(cellValue);
                                                if (cDate != null && cDate.Hour > 0) { cell.CellStyle = dateTimeCellStyle; }
                                                else { cell.CellStyle = dateCellStyle; }
                                            }
                                            break;
                                        default:
                                            break;
                                    }
                                    iCol++;
                                }
                            }
                            iRow++;
                        }

                        GC.Collect();
                        GC.WaitForPendingFinalizers();
                        int columnNumber = 0;
                        foreach (DataColumn columna in pDatos.Columns)
                        {
                            worksheet.AutoSizeColumn(columnNumber);
                            if (worksheet.GetColumnWidth(columnNumber) < 64780)
                                worksheet.SetColumnWidth(columnNumber, worksheet.GetColumnWidth(columnNumber) + 500);
                            columnNumber++;
                        }
                        workbook.Write(stream);
                        stream.Close();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static DataTable DataTableRemoveColumn(DataTable pDatos, string strColumnRemove)
        {
            if (strColumnRemove != "")
            {
                string[] strColumns = strColumnRemove.Split(',');

                for (int i = 0; i < strColumns.Length; i++)
                {
                    if (pDatos.Columns.Contains(strColumns[i].ToString()))
                        pDatos.Columns.Remove(strColumns[i].ToString());
                }
            }
            return pDatos;
        }


    }
}
