import { api, LightningElement } from 'lwc';
import saveChecklist from '@salesforce/apex/ChecklistController.saveChecklist'
export default class Checklist extends LightningElement {
    @api recordId;

    safetyCheck=false;
    equipmentCheck=false;
    meterCheck=false;

    remarks='';

    handleChange(event){
        const fieldName = event.target.name;
        if(event.target.type === 'checkbox'){
            this[fieldName] = event.target.checked;
        } else {
            this[fieldName] = event.target.value;
        }
    }
     handelSubmit(){
        if(
            !this.safetyCheck ||
            !this.equipmentCheck ||
            !this.meterCheck 
        ){
            alert ('Please complete all cheklist items');
            return;
        }
        //apex server needs connectivity 
        if(!this.isOnline){
            alert('network required');
            return;
        }
        saveChecklist({
            serviceAppointmentId: this.recordId,
            safetyCheck: this.safetyCheck,
            equipmentCheck: this.equipmentCheck,
            meterCheck: this.meterCheck,
            remarks: this.remarks
        })
        .then(() => {
            alert('Checklist saved successfully');
            const completionEvent = new CustomEvent('formcomplete',{
                detail: {
                    formName: 'Checklist'
                }
            }
        );

        this.dispatchEvent(
            completionEvent
        );
          })
        .catch (error => {
          console.error(error);
        });
     }
}