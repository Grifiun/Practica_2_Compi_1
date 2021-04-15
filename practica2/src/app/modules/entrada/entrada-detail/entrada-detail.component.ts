import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-entrada-detail',
  templateUrl: './entrada-detail.component.html',
  styleUrls: ['./entrada-detail.component.css']
})
export class EntradaDetailComponent implements OnInit {
  public title = {
    text: 'DETALLES',
    type: 'primary'
  };
  constructor() { }

  ngOnInit(): void {
  }

}
