import { api, LightningElement } from 'lwc';

export default class GasCompletionForm extends LightningElement {
    @api recordId;

    showChecklist= true;
    handleFormComplete(event){
        const formName = event.detail.formName;

        console.log('Completed Form',formName);
    }
}