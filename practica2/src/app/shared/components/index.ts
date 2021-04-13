//Index de tipo TypeScript
import { Component } from '@angular/core';
import { TitleH1Component } from './title-h1/title-h1.component';
//Importamos componentes

export const Components: any[] = [
    //exportamos componentes, constantes
    TitleH1Component
];

//export all components
export * from './title-h1/title-h1.component';//exportamos la data del titulo
