import { LightningElement } from 'lwc';

const appName = 'Runescape';

export default class MyFirstLWC extends LightningElement {

    message = `Welcome to ${appName}`;
    stuffToDo = ['Study', 'Clean', 'Go to the gym', 'Cook', 'Sleep'];
    aboutMe = {
        job: 'SF Dev',
        hobby: 'Gaming',
        goal: 'Become a professional programmer'
    };

    friends = [
        {
            id: 1,
            name: 'Joe',
            job: 'Classified',
            hobby: 'Video Games'
        },
        {
            id: 2,
            name: 'Kate',
            job: 'Teacher',
            hobby: 'Reading'
        }
    ];

    clickedButtonLabel;

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
        console.log('Button label', this.clickedButtonLabel);
    }

    handleClick2(event) {
        this.inputValue = null;
        console.log('Deleting button label', this.clickedButtonLabel);
    }

    inputValue;

    handleInputChange(event) {
        this.inputValue = event.target.value;
        console.log('Input value', this.inputValue);
    }
}