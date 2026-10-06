import { LightningElement } from 'lwc';

export default class AccountContainer2 extends LightningElement {
    selectedContactName;
    handleContactSelect(event){
        const contact = event.detail;
        this.selectedContactName = contact.Name;
    }
}



