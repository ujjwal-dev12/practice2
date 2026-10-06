import { LightningElement } from 'lwc';

export default class Getter extends LightningElement {

    contacts= [
        { id:1 , Name: 'John Smith'},
        { id:2 , Name: 'Amy Taylor'},
        { id:3 , Name: 'Michael'}
    ]

get filteredContacts(){
    return
    this.contacts.filter(contact => 
        contact.Name.toLowerCase().includes(
            this.searchKey.toLowerCase()
        )
    );
}



}