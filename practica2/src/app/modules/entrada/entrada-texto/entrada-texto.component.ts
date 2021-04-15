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

  scrollNum: any;
  scrollNum2: any;
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

    //agregamos el valor
    for(var i = 1; i <= count; i++){
      this.contador += ''+i+'\n';
    }
    //alert(this.contador);
  }
  analizar(texto: string){
    alert("texto a analizar:\n"+texto);
    GramaticaParser.parse(texto);
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

}
