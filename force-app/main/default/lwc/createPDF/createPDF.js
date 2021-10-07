import { LightningElement } from 'lwc';
import pdflib from '@salesforce/resourceUrl/pdflib';
import { loadScript } from "lightning/platformResourceLoader";

export default class CreatePDF extends LightningElement {
    renderedCallback() {
        loadScript(this, pdflib);
        //.then(() => {});
        //Did not work. Removed the promise part
      }
    async createPdf() {
        const pdfDoc = await PDFLib.PDFDocument.create()
        const timesRomanFont = await pdfDoc.embedFont(PDFLib.StandardFonts.TimesRoman)
      
        const page = pdfDoc.addPage()
        const { width, height } = page.getSize()
        const fontSize = 30
        page.drawText('Creating PDFs in JavaScript is awesome!', {
          x: 50,
          y: height - 4 * fontSize,
          size: fontSize,
          font: timesRomanFont,
          color: PDFLib.rgb(0, 0.53, 0.71),
        })
      
        const pdfBytes = await pdfDoc.save();
        this.saveByteArray("my pdf file", pdfBytes);
      }

      saveByteArray(pdfName, byte){
          var blob= new Blob([byte],{type:"application/pdf"});
          var link=document.createElement("a");
          link.href = window.URL.createObjectURL(blob);
          var fileName=pdfName;
          link.download=fileName;
          link.click();
      }


}