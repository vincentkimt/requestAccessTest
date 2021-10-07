import { LightningElement, wire, api } from 'lwc';
import getAccountsToLWC from '@salesforce/apex/AccountsController.getAccountsToLWC'
import getAccounts from '@salesforce/apex/AccountsController.getAccounts'
import saveAccountToSF from '@salesforce/apex/AccountsController.saveAccountToSF'

export default class LWC_GetAccounts extends LightningElement {

    @api message='This is message';
    accountList;
    result;
    error;
    newIndustry;
    newWebsite;
    newRating;
    newRevenue;
    accountId;
    errorParentChild;
    resultParentChild


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
    saveAccountDetails(event){
 
        this.accountId=event.detail.AccountId;
        this.newRevenue=event.detail.Revenue;
        this.newWebsite=event.detail.Website;
        this.newRating=event.detail.Rating;
        this.newIndustry=event.detail.Industry;
        alert('inside parent-'+this.accountId);
        saveAccountToSF({ id: this.accountId,Industry:this.newIndustry,Rating: this.newRating, website: this.newWebsite,revenue:this.newRevenue })
        .then(result=>{
            this.resultParentChild=result;
            window.console.log('Success --',this.resultParentChild);
            getAccounts()
            .then(result=>{
            this.accountList=result;
            this.error=undefined;
            window.console.log('accountList->',this.accountList);
            }).catch(error=>{
            this.error=error;
            this.accountList=undefined;
            });
        }).catch(error=>{
            this.errorParentChild = error
            window.console.log('error --',this.errorParentChild);
        });
    }

  


}