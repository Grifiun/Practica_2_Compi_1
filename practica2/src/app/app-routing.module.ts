//import { NgModule, Component } from '@angular/core';
import { NgModule, CUSTOM_ELEMENTS_SCHEMA } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SkeletonComponent } from './layout/skeleton/skeleton.component';

const routes: Routes = [
 {
  path: '',
  component: SkeletonComponent,   
  children: [
    {
      path: '',
      loadChildren: () =>
        import('./modules/entrada/entrada.module').then((m) => m.EntradaModule )
        //import('@modules/entrada/entrada.module').then((m) => m.EntradaModule )
    }
  ]
  
 
}
];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],//quitamos el # del url 

 exports: [RouterModule]
})
export class AppRoutingModule { }

