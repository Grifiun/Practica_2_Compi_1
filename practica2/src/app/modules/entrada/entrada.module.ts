import { NgModule } from '@angular/core';
import { SharedModule } from '../../shared/shared.module';
import { EntradaTextoComponent } from './entrada-texto/entrada-texto.component';
import { EntradaDetailComponent } from './entrada-detail/entrada-detail.component';
import { EntradaRoutingModule } from './entrada-routing.module';

@NgModule({
  declarations: [
    EntradaDetailComponent,
    EntradaTextoComponent
  ],
  imports: [  
    SharedModule,
    EntradaRoutingModule
  ]
})
export class EntradaModule { }
