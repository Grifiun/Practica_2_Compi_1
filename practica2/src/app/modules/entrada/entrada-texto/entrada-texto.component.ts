import { Component, OnInit } from '@angular/core';
@Component({
  selector: 'app-entrada-texto',
  templateUrl: './entrada-texto.component.html',
  styleUrls: ['./entrada-texto.component.css']
})
export class EntradaTextoComponent implements OnInit {
  contador: string = '';

  constructor() { }

  ngOnInit(): void {
  }

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



}
