import { LightningElement } from 'lwc';

export default class ContactSelector2 extends LightningElement {
    selectedContact = {
        Id: '003AWF456',
        Name: 'John Smith'
    }
    handleSelect(){
        const contactEvent = new CustomEvent('contactselect',{
            detail:this.selectedContact
        });
        this.dispatchEvent(contactEvent);
    }
}