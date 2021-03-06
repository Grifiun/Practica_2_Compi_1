import { Component, OnInit } from '@angular/core';
import * as GramaticaParser from '../../../assets/gramatica.js';
import { HostListener } from '@angular/core';

@Component({
  selector: 'app-entrada-texto',
  templateUrl: './entrada-texto.component.html',
  styleUrls: ['./entrada-texto.component.css']
})
export class EntradaTextoComponent implements OnInit {
  contador: string = '';
  contador2: string = '';
  colNum1;
  colNum2;
  scrollNum: any;
  scrollNum2: any;
  analisisEntrada;
  constructor() {

  }

  ngOnInit(): void {
  }

  //ENTRADA
  cambioTexto(texto: string){
    this.contador = '';
    //alert(texto);
    //contamos las lineas
    var lines = texto.split(/\r|\r\n|\n/);
    var count = lines.length;   

    if(count > 0 && count < 100){
      this.colNum1 = 1;
    }else if(count >= 100 && count < 1000){
      this.colNum1 = 2;
    }else{
      this.colNum1 = 3;
    }

    //agregamos el valor
    for(var i = 1; i <= count; i++){
      this.contador += ''+i+'\n';
    }
    //alert(this.contador);
  }  

  @HostListener('scroll', ['$event'])
  onScrollNum($event, scrollT) {
    this.scrollNum = scrollT;
  }

  @HostListener('scroll', ['$event'])
  onScrollEnt($event, scrollT) {
    this.scrollNum = scrollT;
  }


  ////SALIDA
  cambioTexto2(texto: string){
    this.contador2 = '';
    //alert(texto);
    //contamos las lineas
    var lines = texto.split(/\r|\r\n|\n/);
    var count = lines.length;

    if(count > 0 && count < 100){
      this.colNum2 = 1;
    }else if(count >= 100 && count < 1000){
      this.colNum2 = 2;
    }else{
      this.colNum2 = 3;
    }

    //agregamos el valor
    for(var i = 1; i <= count; i++){
      this.contador2 += ''+i+'\n';
    }
    //alert(this.contador);
  }

  @HostListener('scroll', ['$event'])
  onScrollNum2($event, scrollT) {
    this.scrollNum2 = scrollT;
  }

  @HostListener('scroll', ['$event'])
  onScrollEnt2($event, scrollT) {
    this.scrollNum2 = scrollT;
  }

  //TEXTO DEL PARSER
  analizar(texto: string){
    var analisisEntrada = '';
    var gram = GramaticaParser;
    //alert("texto a analizar:\n"+texto);
    GramaticaParser.parse(texto);
    var listaErroresParser = gram.listaErroresParser;    

    //if(listaErroresParser != null && listaErroresParser.lenght > 0){

    try {        
      for(var i = 0; i < listaErroresParser.length; i++){
        analisisEntrada += listaErroresParser[i]; 
      }
    } catch (error) {
      analisisEntrada = '';
    }

    this.analisisEntrada = analisisEntrada

    //gram = null;
    GramaticaParser.listaErroresParser.splice(0, listaErroresParser.length);
    GramaticaParser.listaErroresParser.length = 0;
    //GramaticaParser.listaErroresParser = null;   
  }

}
