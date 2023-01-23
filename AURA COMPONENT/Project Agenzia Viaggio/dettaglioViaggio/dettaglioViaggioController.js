/**
 * @description       : 
 * @author            : Christian Niro
 * @group             : 
 * @last modified on  : 10-19-2022
 * @last modified by  : 
**/
({
    // Load expenses from Salesforce
    doInit: function(component, event, helper) {
        // Create the action
        var action = component.get("c.getAllObjects");
        // Add callback behavior for when response is received
        var opts=[];
        action.setCallback(this, function(response) {
            var state = response.getState();
            console.log(response.getReturnValue());
            if (state == "SUCCESS") {
               var allValues = response.getReturnValue();
                for (var i = 0; i < allValues.length; i++) {
                    opts.push({
                        class: "optionClass",
                        label: allValues[i],
                        value: allValues[i]
                    });
            }
                 component.find("SobjectList").set("v.options", opts);
            }
            else {
                console.log("Failed with state: " + state);
            }
        });
        // Send action off to be executed
        $A.enqueueAction(action);
    },
    getfields: function(component, event, helper) { 
       var action = component.get("c.getAllFields");
       var userObj=component.find("SobjectList").get("v.value");
        action.setParams({
            "fld": userObj
        });
       
            
            action.setCallback(this, function(response){
                var state = response.getState();
                if(state == 'SUCCESS'){
    
                    component.set('v.vggListDisplay', response.getReturnValue());
    
                }
            });
            $A.enqueueAction(action);
    },

    onClear : function(component, event, helper) {
        
         window.setTimeout(function(){ $A.get('e.force:refreshView').fire(); }, 1); 
         window.location.href = "/lightning/n/Trivago";

     },
        
    
})