import { api, LightningElement } from 'lwc';

export default class GasCompletionfinal extends LightningElement {
    @api recordId;
    
// controlling child forms 
    showChecklist = true;
    showGasMeter = true;

//trakcs completion
checklistCompleted = false;
gasMeterCompleted = false;

//Practice network indicator 
isOnline = navigator.onLine;

//File types allowed 
acceptedFormats =[
    '.jpg',
    '.jpeg',
    '.png',
    '.pdf'
];

connectedCallback(){
    window.addEventListener(
        'online',
        this.handleOnline
    );
    window.addEventListener(
        'offline',
        this.handleOffline
    );
}

disconnectedCallback(){
    window.removeEventListener(
        'online',
        this.handleOnline
    );
    window.removeEventListener(
        'offline',
        this.handleOffline
    );
}

handleOffline = () => {
    this.isOnline = false;
}

handleOnline = () => {
    this.isOnline = true;
}

get isOffline(){
  return !this.isOnline;
}

handleFormComplete(event){
    const formName = event.detail.formName;

    if(formName == 'Checklist'){
        this.checklistCompleted =true;
    }
    if(formName == 'GasMeter'){
        this.gasMeterCompleted =true;
    }
}

get isSaveCompleteDisabled(){
    return !(
        this.checklistCompleted && this.gasMeterCompleted
    );
}

handleUploadFinished(event){
    const uploadedFiles = event.detail.files;
    console.log('Uploded Files:',uploadedFiles);

    uploadedFiles.forEach(file => {
        console.log('File Name:',file.name);
        console.log('Document Id:',file.documentId);
    });
}

handleSaveComplete(){
    console.log(
        'All mandatory forms completed'
    );
    alert('Work completion can now continue');
  }
}