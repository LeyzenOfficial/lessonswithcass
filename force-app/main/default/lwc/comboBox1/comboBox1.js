import { LightningElement } from 'lwc';

export default class ComboboxBasic extends LightningElement {
    value = 'inProgress';

    
    options = [
            { label: 'New', value: 'new' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
            { label: 'Hello', value: 'world'},
    ];
    

    handleChange(event) {
        this.value = event.detail.value;
        console.log(event);
        console.log('current value', this.value);
    }
}
