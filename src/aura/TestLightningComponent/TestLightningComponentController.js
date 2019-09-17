/**
 * Created by Pavel on 05.09.2019.
 */

({
    doInit: function (component, event, helper) {
        helper.init(component);
    },
    viewAccountDetails: function (component, event, helper) {
        var acc = event.getSource().get('v.value');
        console.log('acc', acc);
        if (acc) {
            helper.viewContactDetails(component, acc);
        }
    }
});