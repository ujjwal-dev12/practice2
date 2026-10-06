import { api, LightningElement } from 'lwc';
import getQuestions from '@salesforce/apex/ChecklistController.getQuestions';

export default class DynamicChecklist extends LightningElement {

    @api recordId;
    questions = [];

    isLoading=false;
    errorMessage;

    connectedCallback(){
        this.loadQuestions();
    }

    async loadQuestions(){

        this.isLoading = true;
        this.errorMessage = undefined;

        try{
            const result = await getQuestions({ workOrderId: this.recordId });

            this.questions = result.map(question => {
                return {
                    ...question,
                    answer: '',
                    inputType: this.getInputType (
                        question.questionType
                    )
                };
            });
        }  catch (error) {
             console.error('Error loading checklist', error);
             this.errorMessage = 'Unable to load checklist questions';
        } finally {
            this.isLoading = false;
        }
    }

    getInputType (questionType){
        if(!questionType){
            return 'text';
        }
        const type = questionType.toLowerCase();

        if(type === 'number' || type === 'numeric'){
            return 'number';
        }
        if(type === 'date'){
            return 'date';
        }
        if(type === 'boolean' || type === 'checkbox'){
            return 'checkbox';
        }

        return 'text';
    }

    handleAnswer(event){
        const questionId = event.target.dataset.id;
        const inputType = event.target.type;
        const answer = inputType === 'checkbox' ? event.target.checked : event.target.value;

        this.questions = this.questions.map(question => {
            if(
                question.questionId === questionId
            ){
                return {
                    ... question, answer: answer
                };
            }
            return question;
        });
        console.log('Updated question',JSON.stringify(this.questions));
    }
}