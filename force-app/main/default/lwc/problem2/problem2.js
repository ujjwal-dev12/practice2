import { LightningElement, wire } from 'lwc';
import getContactsByAccount from '@salesforce/apex/ContactController.getContactsByAccount'

export default class Problem2 extends LightningElement {
    @api recordId;
    contacts;
    error;

    @wire(getContactsByAccount,{accountId:$recordId})
}