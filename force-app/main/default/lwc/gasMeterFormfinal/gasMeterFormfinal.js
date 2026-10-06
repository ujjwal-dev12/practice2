import { api, LightningElement } from 'lwc';
import { updateRecord } from 'lightning/uiRecordApi';
import onlineTemplate from './gasMeterForm.html';
import offlineTemplate from './gasMeterFormOffline.html';
export default class GasMeterFormfinal extends LightningElement {

    @api recordId;
    @api isOnline;

    meterNumber = '';
    meterReading = '';

    render(){
        if(this.isOnline){
            return onlineTemplate;
        }
        return offlineTemplate;
    }

    handleMeterChange(event){
        this.meterNumber = event.target.value;
    }

    handleReadingChange(event){
        this.meterReading = event.target.value;
    }

    async handleSave(){
        if(
            !this.meterNumber || !this.meterReading
        ){
            alert('Please enter meter details');
            return;
        }

        const fields = {
            Id: this.recordId,

            Meter_Number__c: this.meterNumber,
            Meter_Reading__c: this.meterReading
        };

        const recordInput = {
            fields:fields
    };

    try{
        await updateRecord(
            recordInput
        );

        alert('Meter Information Saved');

        const completionEvent = new CustomEvent('formcomplete',{
            detail: {
                formName: 'Gas Meter'
            }
        });
        this.dispatchEvent(
            completionEvent
        );
    } catch (error){
        console.error('meter save error ', error);
    }

    handleHostValidation(){
        if(!this.isOnline){
            alert('host validation require network');
            return;
        }
        console.log('Here we would call Host validation');
    }

}