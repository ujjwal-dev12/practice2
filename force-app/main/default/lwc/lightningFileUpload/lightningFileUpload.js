import { api, LightningElement } from 'lwc';

export default class LightningFileUpload extends LightningElement {
    @api recordId;

    acceptedFormats = [
        '.jpg',
        '.jpeg',
        '.png',
        '.pdf'
    ];

    handleUploadFinished(event){
        const uploadedFiles = event.detail.files;
        console.log('Files uploaded:',uploadedFiles);
        console.log('Number of files:',uploadedFiles.length);

    }
}