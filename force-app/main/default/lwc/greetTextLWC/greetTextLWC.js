import { LightningElement,track } from 'lwc';

export default class GreetTextLWC extends LightningElement {

    @track greeting='hello user';

    greetUser(event){
        let textInput= this.template.querySelector(".txtInput");
        this.greeting = textInput.value;
    }



}