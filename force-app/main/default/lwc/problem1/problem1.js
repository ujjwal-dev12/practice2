import { LightningElement } from 'lwc';
import updateAccount from '@salesforce/apex/AccountController.updateAccount'
export default class Problem1 extends LightningElement {
    handleUpdate(){
        updateAccount({
            accountId: this.recordId,
            newName: this.accountName
        })
        .then(() => {
            console.log('Account updated');
        })
        .catch(error =>{
            console.error(error)
        })
    }
}



