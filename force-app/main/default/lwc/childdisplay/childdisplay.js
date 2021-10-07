import { LightningElement,api,track } from 'lwc';
import {NavigationMixin} from 'lightning/navigation';                             

export default class Childdisplay extends NavigationMixin(LightningElement) {
    @api accountrec;
    @track openModal = false;
    newIndustry;
    newWebsite;
    newRating;
    newRevenue;
    @api index;
    @api conId;
   
    showModal(){
        this.openModal = true;
        this.newIndustry=this.accountrec.Industry;
        this.newWebsite=this.accountrec.Website;
        this.newRevenue=this.accountrec.AnnualRevenue;
        this.newRating=this.accountrec.Rating;
        window.console.log('newWebsite',this.newWebsite);
    }
    closeModal() {
        this.openModal = false;
    }
    handleChangeIndustry(event){
        this.newIndustry = event.target.value;
    }
    handleChangeWebsite(event){
        this.newWebsite = event.target.value;
        window.console.log('handleChangeWebsite')
    }
    handleChangeRating(event){
        this.newRating = event.target.value;
    }
    handleChangeRevenue(event){
        this.newRevenue = event.target.value;
    }
    sendEvent(){

        let accIdLocal = this.accountrec.Id;
        let IndustryLocal = this.newIndustry;
        let WebsiteLocal = this.newWebsite;
        let RatingLocal = this.newRating;
        let RevenueLocal = this.newRevenue;
        window.console.log('sending Id---',accIdLocal);
        window.console.log('sending Industry---',IndustryLocal);
        window.console.log('sending Website---',WebsiteLocal);
        window.console.log('sending Rating---',RatingLocal);
        window.console.log('sending Revenue---',RevenueLocal);
        const event=new CustomEvent('saveaccount',{
            detail : {
                AccountId : accIdLocal,
                Industry : IndustryLocal,
                Website : WebsiteLocal,
                Rating : RatingLocal,
                Revenue : RevenueLocal
            }
        });
    this.dispatchEvent(event);
    this.openModal = false;
    
    }



    navigateToAccount(){

        window.console.log('button cliked',this.accountrec.Id);
        const config= {
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Account',
                actionName: 'new'
            }
        };

        this[NavigationMixin.Navigate](config);
    }
}