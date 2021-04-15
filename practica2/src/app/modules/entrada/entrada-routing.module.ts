import { NgModule, Component } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { EntradaTextoComponent } from './entrada-texto/entrada-texto.component';
import { EntradaDetailComponent } from './entrada-detail/entrada-detail.component';

const routes: Routes = [
 {
  path: '',
  component: EntradaTextoComponent
 },
 {
    path: 'detail',
    component: EntradaDetailComponent
 }
];

@NgModule({
  imports: [RouterModule.forChild(routes)],//quitamos el # del url
 


  exports: [RouterModule]
})
export class EntradaRoutingModule { }
