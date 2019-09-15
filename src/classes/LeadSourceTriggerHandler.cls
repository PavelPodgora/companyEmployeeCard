public with sharing class LeadSourceTriggerHandler {
    
    public LeadSourceTriggerHandler() {

    }

public void onAfterInsert(List<Lead> triggerNewList){
        List<Lead> listLeads = new List<Lead>();
        List<String> listLeadSources = new List<String>();
        List<String> listParentNotChilds = new List<String>();
        List<Id> listChildIds = new List<Id>();
        List<String> listChildName = new List<String>();
        List<Campaign> listNewChild = new List<Campaign>();
        List<CampaignMember> listAssigLead = new List<CampaignMember>();
        Map<String,Id> mapNamesWithParentId = new Map<String,Id>();
        Map<Id,Id> mapIdWithChilds = new Map<Id,Id>();
        Map<String,Lead> mapLeads = new map<String,Lead>();
        

        for(Lead l: triggerNewList){
            mapLeads.put(l.LeadSource, l);
        }

        for(Lead l: triggerNewList){
            listLeadSources.add(l.LeadSource);
        }

        for(Lead l: triggerNewList){
            Integer leadDate = l.CreatedDate.date().Month();
            String fullChildName = l.LeadSource + '_' + leadDate;
            listChildName.add(fullChildName);
        }

        List<Campaign> listParentIds = [SELECT Id, Name FROM Campaign WHERE Name IN: listLeadSources];
        List<Campaign> listChilds = [SELECT Id,Name, ParentId FROM Campaign WHERE ParentId IN: listParentIds AND Name IN: listChildName AND StartDate < TODAY AND EndDate > TODAY];

        for(Campaign cam: listChilds){
            listChildIds.add(cam.ParentId);
        }

        for(Campaign c: listParentIds){
            mapNamesWithParentId.put(c.Name, c.Id);
        }
        
        if(listParentIds.size()!= 0){
            for(Campaign CamParent: listParentIds){
                if(!listChildIds.contains(CamParent.Id)){
                    Lead leadEveryone = mapLeads.get(CamParent.Name);
                    Campaign childCampaign = new Campaign();
                    childCampaign.Name = leadEveryone.LeadSource + '_' + leadEveryone.CreatedDate.Month();
                    childCampaign.ParentId = CamParent.Id;
                    childCampaign.StartDate = leadEveryone.CreatedDate.date().toStartOfMonth();
                    childCampaign.EndDate = leadEveryone.CreatedDate.date().addMonths(1).toStartofMonth().addDays(-1);
                    listNewChild.add(childCampaign);
                }
            }

            insert listNewChild;
            listChilds = [SELECT Id,Name, ParentId FROM Campaign WHERE ParentId IN: listParentIds AND Name IN: listChildName];

            for(Campaign c: listChilds){
            	mapIdWithChilds.put(c.ParentId, c.Id);
        	}

            for(Lead l: triggerNewList){
                Id parentId = mapNamesWithParentId.get(l.LeadSource);
                Id childId = mapIdWithChilds.get(parentId);
                CampaignMember campMemb = new CampaignMember();
                campMemb.CampaignId = childId; 
                campMemb.LeadId = l.Id;
                listAssigLead.add(campMemb);
            }
        }
        else{
            listLeads[0].addError('There is no such campaign');
        }

            insert listAssigLead;
            update listAssigLead;
    }

    // public void returnLeadSource(List<String> listLeadSources,List<Lead> triggerNewList ){
    //     for(Lead l: triggerNewList){
    //         listLeadSources.add(l.LeadSource);
    //     }
    // }
}