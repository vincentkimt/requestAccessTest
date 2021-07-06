import { LightningElement } from 'lwc';

export default class LWC_EventRaise extends LightningElement {

    raiseEvent(event){
        let textInput= this.template.querySelector(".txtInput");
        const v = textInput.value;

        const textEventChange = new CustomEvent('txtChange',{
            detail : {v}
        });

        this.dispatchEvent(textEventChange);
    }
}