<aura:application extends="force:slds">
    <aura:attribute name="msg" type="String" />
  
   
    <c:Demo11Toggle />
    <hr/>
     <c:Demo10ControllerPractice />
    
    
    <c:Demo2AllAttribute/>
    <c:Demo3FacetComponent>
        
        Demo data 1
        <aura:set attribute="facetDemo">
            FacetText 1<br/>
        	FacetText 2<br/>
		</aura:set>
        Demo data 2
    </c:Demo3FacetComponent>

    <c:Demo4LocalIdGlobalId />
    <BR/> <BR/> <BR/> <BR/> <BR/>   --------Demo for CSS--------
    <c:Demo8CSSStyle />
    <c:Demo9Breadcrumb />
    <c:Demo10Accordian />
   
</aura:application>