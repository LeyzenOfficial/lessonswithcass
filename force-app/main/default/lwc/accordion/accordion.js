import { LightningElement } from 'lwc';
import LightningModal from 'lightning/modal';

//Apex method imports
import caseGrabber from '@salesforce/apex/CaseService.caseGrabber';
import oppGrabber from '@salesforce/apex/OpportunityService.opportunityGrabber';
import taskGrabber from '@salesforce/apex/TaskService.taskGrabber';

//Toast import
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const caseColumns = [
    { label: 'Case Number', fieldName: 'CaseNumber'},
    { label: 'Status', fieldName: 'Status'},
    { label: 'Origin', fieldName: 'Origin'},
    { label: 'Type', fieldName: 'Type'},
    
];

const opportunityColumns = [
    { label: 'Name', fieldName: 'Name'},
    { label: 'Id', fieldName: 'Id'},
    { label: 'StageName', fieldName: 'StageName'},
    { label: 'CloseDate', fieldName: 'CloseDate'},
    
];

const taskColumns = [
    { label: 'Id', fieldName: 'Id'},
    { label: 'WhoId', fieldName: 'WhoId'},
    { label: 'Subject', fieldName: 'Subject'},
    
];

export default class LightningExampleAccordionBasic extends LightningElement {


    //DataTable
    caseColumns = caseColumns;
    opportunityColumns = opportunityColumns;
    taskColumns = taskColumns;

    //Object records
    cases;
    opportunities;
    tasks;

    //Record Values
    inputValueCases;
    inputValueOpportunities;
    inputValeuTasks;

    //On click grabs case
    getCase(){ 

        if(this.inputValueCases <= 0){
            const evt = new ShowToastEvent({
                title: 'error!',
                message: 'Value must be greater than 0!',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }else{
            
        caseGrabber({i : this.inputValueCases})
            .then(result => {
                this.cases = result;
                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Accounts successfully loaded!',
                    variant: 'success',
                });
                this.dispatchEvent(evt);

            })
            .catch(error => {
                console.error(error);
                const evt = new ShowToastEvent({
                    title: 'ERROR!',
                    message: error.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            });
        }
    }

    //On click grabs opportunity
    getOpportunities(){ 

        if(this.inputValueOpportunities <= 0){
            const evt = new ShowToastEvent({
                title: 'error!',
                message: 'Value must be greater than 0!',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }else{
            
        oppGrabber({i : this.inputValueOpportunities})
            .then(result => {
                this.opportunities = result;
                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Accounts successfully loaded!',
                    variant: 'success',
                });
                this.dispatchEvent(evt);

            })
            .catch(error => {
                console.error(error);
                const evt = new ShowToastEvent({
                    title: 'ERROR!',
                    message: error.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            });
        }
    }

    //On click grabs tasks
    getTask(){ 

        if(this.inputValueTasks <= 0){
            const evt = new ShowToastEvent({
                title: 'error!',
                message: 'Value must be greater than 0!',
                variant: 'error',
            });
            this.dispatchEvent(evt);
        }else{
            
        taskGrabber({i : this.inputValueTasks})
            .then(result => {
                this.tasks = result;
                const evt = new ShowToastEvent({
                    title: 'Success!',
                    message: 'Accounts successfully loaded!',
                    variant: 'success',
                });
                this.dispatchEvent(evt);

            })
            .catch(error => {
                console.error(error);
                const evt = new ShowToastEvent({
                    title: 'ERROR!',
                    message: error.body.message,
                    variant: 'error',
                });
                this.dispatchEvent(evt);
            });
        }
    }


    handleInputChangeCases(event){

        this.inputValueCases = event.target.value;
    }

    handleInputChangeOpportunities(event){

        this.inputValueOpportunities = event.target.value;
    }

    handleInputChangeTasks(event){

        this.inputValueTasks = event.target.value;
    }


}
