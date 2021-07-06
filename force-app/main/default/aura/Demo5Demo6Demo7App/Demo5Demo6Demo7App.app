<aura:application >
    <aura:attribute name="showBounded" type="boolean" default="true" />
                    
                    
    <lightning:button variant="base" label="showBoundedUnBounded" title="Base action" 
                     
                     onclick="{!c.showBoundedUnBounded}" aura:id="LocalID"/>
	<aura:if isTrue="{!v.showBounded}">
    <c:Demo5BoundedComponent />
    
    <aura:set attribute="else">
        <c:Demo6UnBoundedComponent />
    </aura:set>
    
    </aura:if>
</aura:application>