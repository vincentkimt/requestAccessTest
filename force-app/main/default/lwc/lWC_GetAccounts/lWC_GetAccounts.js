import { LightningElement, wire, api } from 'lwc';
import getAccountsToLWC from '@salesforce/apex/AccountsController.getAccountsToLWC'
import getAccounts from '@salesforce/apex/AccountsController.getAccounts'
export default class LWC_GetAccounts extends LightningElement {

    @api message='This is message';
    accountList;
    result;
    error;
    @wire(getAccountsToLWC)
    wiredData({error,data}){

        if(data){
            this.result=data;
            this.error=undefined;
            window.console.log('data->',this.result);
        }else if(error){
            this.error=error;
            this.data= undefined;
            window.console.log('error->',this.error);
        }
    }

    handleGetAccount(event){
        
        getAccounts()
        .then(result=>{
            this.accountList=result;
            this.error=undefined;
            window.console.log('accountList->',this.accountList);
        }).catch(error=>{
            this.error=error;
            this.accountList=undefined;
        });
    }


  


}