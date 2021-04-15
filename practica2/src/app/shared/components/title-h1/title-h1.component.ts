import { Component, OnInit, Input } from '@angular/core';
import { ITitleH1 } from './normal-title.metadata';

@Component({
  selector: 'app-title-h1',
  templateUrl: './title-h1.component.html',
  styleUrls: ['./title-h1.component.css']
})
export class TitleH1Component implements OnInit {
  @Input() data: ITitleH1 = {
    text: '',
    type: 'primary'
  };//datos inciales
  constructor() { }
  ngOnInit(): void {
  }

}
