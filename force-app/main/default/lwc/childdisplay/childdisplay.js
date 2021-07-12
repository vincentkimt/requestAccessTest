import { LightningElement,api } from 'lwc';
import getContact from '@salesforce/apex/AccountsController.getContact'
export default class Childdisplay extends LightningElement {
    @api accountrec;
  
    @api index;
    @api conId;
   
}