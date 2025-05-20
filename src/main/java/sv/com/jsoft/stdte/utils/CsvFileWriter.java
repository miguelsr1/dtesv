package sv.com.jsoft.stdte.utils;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import sv.com.jsoft.stdte.dto.ExcelFileDTO;

import java.text.SimpleDateFormat;
import java.util.List;

public class CsvFileWriter {

    static final Logger logger = Logger.getLogger(CsvFileWriter.class);
    public static Workbook generateExcelFile(List<ExcelFileDTO> dataList) {
        try {
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Hoja1");
            Row headerRow = sheet.createRow(0);

            // Merge Cells for headers with span columns
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 14));
            Cell headerCell1 = headerRow.createCell(0);
            headerCell1.setCellValue("SISTEMA TRANSMISIÓN DTE STC"); // first Header

            // Create sub-headers
            Row subHeaderRow = sheet.createRow(1);
            String[] subHeaders = { "Estado Hacienda", "Tipo de Documento", "Fecha", "Hora", "Número de control", "Código generación", "Sello de recepción", "Identificación receptor",
                    "Nombre receptor", "Condición de venta", "Tipo cambio", "Moneda", "Monto Impuestos", "Monto Total", "Usuario" };
            for (int i = 0; i < subHeaders.length; i++) {
                Cell cell = subHeaderRow.createCell(i);
                cell.setCellValue(subHeaders[i]);
            }
            // Create data rows
            int rowNum = 2;
            for (ExcelFileDTO obj : dataList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(obj.getEstado());
                row.createCell(1).setCellValue(obj.getDocumento());
                row.createCell(2).setCellValue(obj.getFecha());
                row.createCell(3).setCellValue(obj.getHora());
                row.createCell(4).setCellValue(obj.getControl());
                row.createCell(5).setCellValue(obj.getCodigoGeneracion());
                row.createCell(6).setCellValue(obj.getSelloRecepcion());
                row.createCell(7).setCellValue(obj.getIdentificacionReceptor());
                row.createCell(8).setCellValue(obj.getNombre());
                row.createCell(9).setCellValue(obj.getCondicionVenta());
                row.createCell(10).setCellValue(obj.getTipoCambio());
                row.createCell(11).setCellValue(obj.getMoneda());
                row.createCell(12).setCellValue(obj.getMontoImpuesto().toString());
                row.createCell(13).setCellValue(obj.getMontoTotal().toString());
                row.createCell(14).setCellValue(obj.getUsuario());
            }
            for (int i = 0; i < subHeaders.length; i++) {
                sheet.autoSizeColumn(i);
            }
            logger.info("Excel file created successfully!");
            return workbook;
        } catch (Exception e) {
            logger.error("Error en generateExcelFile: " + e);
            return null;
        }

    }

    public static Workbook generateExcelFileBrillo(List<ExcelFileDTO> dataList){
        try {
            Workbook workbook = new XSSFWorkbook();
            Sheet sheet = workbook.createSheet("Hoja1");
            Row headerRow = sheet.createRow(0);

            // Merge Cells for headers with span columns
            sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 41));
            Cell headerCell1 = headerRow.createCell(0);
            headerCell1.setCellValue("SISTEMA TRANSMISIÓN DTE FORMATO BRILO STC"); // first Header

            // Create sub-headers
            Row subHeaderRow = sheet.createRow(1);
            String[] subHeaders = { "Tipo Factura", "# de Factura", "# Formulario Unico", "Fecha (AAAA-MM-DD)", "Cod. Cliente Facturado a", "Nombre Cliente", "Apellido Cliente",
            "NIT Cliente", "Cod Sucursal del Cliente", "Cod. Cliente CXC a", "Cod. Cliente Enviado a", "Plazo de Credito (en dias)", "Codigo Vendedor", "Codigo Sucursal",
            "Codigo Caja Registradora", "Codigo Tipo de Venta", "% IVA", "% de Percepcion", "% de Retencion", "Concepto", "Codigo Emp Responsable", "Dejar Mov Inv Pendiente",
            "Codigo Centro de Costo", "Codigo SubCentro de Costo", "Codigo de Producto", "Descripcion", "Cantidad", "Precio Unitario","% de Descuento", "Es Exento", "Es No Sujeto",
            "Codigo Centro de Costo Item", "Codigo SubCentro de Costo Item", "Codigo de Ubicacion", "Numero Lote", "Cod Generacion | CodAlfaNum01", "Sello Recep | CodAlfaNum02",
            "CodAlfaNum03", "CodAlfaNum04", "Referencia", "Num de Control", "Fecha de Recepcion"};
            for (int i = 0; i < subHeaders.length; i++) {
                Cell cell = subHeaderRow.createCell(i);
                cell.setCellValue(subHeaders[i]);
            }

            // Create data rows
            int rowNum = 2;
            for (ExcelFileDTO obj : dataList) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(obj.getDocumento());
                row.createCell(1).setCellValue(obj.getCodigoGeneracion());
                row.createCell(2);
                row.createCell(3).setCellValue(obj.getFecha());
                row.createCell(4).setCellValue("0");
                row.createCell(5).setCellValue("CLIENTES");
                row.createCell(6).setCellValue("VARIOS");
                row.createCell(7);
                row.createCell(8);
                row.createCell(9);
                row.createCell(10);
                row.createCell(11);
                row.createCell(12);
                row.createCell(13);
                row.createCell(14);
                row.createCell(15);
                row.createCell(16).setCellValue("0.13");
                row.createCell(17);
                row.createCell(18);
                row.createCell(19);
                row.createCell(20);
                row.createCell(21);
                row.createCell(22);
                row.createCell(23);
                row.createCell(24).setCellValue(obj.getDetCodigo());
                row.createCell(25).setCellValue(obj.getDetFacDescripcion());
                row.createCell(26).setCellValue(obj.getDetFacCantidad());
                row.createCell(27).setCellValue(obj.getDetFacPreciounitario().toString());
                row.createCell(28);
                row.createCell(29);
                row.createCell(30);
                row.createCell(31);
                row.createCell(32);
                row.createCell(33);
                row.createCell(34);
                row.createCell(35).setCellValue(obj.getCodigoGeneracion());
                row.createCell(36).setCellValue(obj.getSelloRecepcion());
                row.createCell(37);
                row.createCell(38);
                row.createCell(39);
                row.createCell(40).setCellValue(obj.getControl());
                row.createCell(41).setCellValue(obj.getFacFechaEmision());
            }
            for (int i = 0; i < subHeaders.length; i++) {
                sheet.autoSizeColumn(i);
            }

            logger.info("Excel file created successfully!");
            return workbook;
        }catch (Exception e){
            logger.error("error en generateExcelFileBrillo: " + e.getStackTrace());
            return null;
        }
    }
}
