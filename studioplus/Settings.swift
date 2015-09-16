//
//  Settings.swift
//  studioplus
//
//  Created by Isaac Ho on 9/1/15.
//  Copyright (c) 2015 gigster. All rights reserved.
//

import Foundation

enum TemplateId {
    var description: String {
        return Settings.templateIdSpecs[self]!.0
    }
    var id: String {
        return Settings.templateIdSpecs[self]!.1
    }
    
    // add your template id here, and also in the templateIdSpecs below...
    case
    ProjectTitle,
    ProjectLogo,
    ProjectNumCreators,
    ProjectIsScripted,
    ProjectIsEpisodic,
    
    PersonFirstName,
    PersonLastName,
    PersonPhoneNumber,
    PersonEmail,
    PersonAddress,
    PersonPrimaryRole,
    PersonSecondaryRole,
    PersonRoleDetails,
    PersonBandName,
    PersonBandNumMembers,
    MaterialType,
    MaterialDescription,
    MaterialFee,
    MaterialFeeType,
    MaterialRentalStartDate,
    MaterialRentalEndDate,
    MaterialExclusiveNonExclusive,
    QuestionsCrewIsProvidingOwnSupplies,
    QuestionsCrewSuppliesDescription,
    QuestionsDirectorRuntime,
    QuestionsPhotographerMinPictures,
    QuestionsPhotographerProjectDetails,
    QuestionsPerformerCharacter,
    QuestionsPerformerPrimaryPlace,
    QuestionsPostProductionCredit,
    QuestionsProducerCredit,
    
    QuestionsTalentStageName,
    QuestionsTalentPreProductionStartDate,
    QuestionsTalentApproximateEndDate,
    QuestionsTalentPrimaryCity,
    QuestionsTalentAgentDetails,
    QuestionsTalentAdditionalConditions,
    QuestionsTalentSelectEpisode,
    QuestionsTalentArtistFee,
    QuestionsTalentPaymentType,
    QuestionsWriterProjectApproximateRuntime,
    QuestionsWriterApproximateNumPagesInScript,
    QuestionsWriterCredit,
    QuestionsWriterNumRevisionsRequired,
    QuestionsCollaboratorRoleDescription,
    QuestionsCollaboratorCredit,
    QuestionsNonTalentFlatFee,
    SignatureOwner,
    SignatureCounterParty
}


class Settings {
    static let sharedInstance = Settings()

    func showError( msg: String, masterVC:UIViewController ) {
        var dialog = UIAlertController(title: "Error", message: msg, preferredStyle: UIAlertControllerStyle.Alert)
        var ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        dialog.addAction(ok)
        
        masterVC.presentViewController(dialog, animated: true, completion: nil)
    }
    static var templateIdSpecs:[TemplateId:(String,String)] = [
        TemplateId.ProjectTitle:("ProjectTitle","8"),
        TemplateId.ProjectLogo:("ProjectLogo","84"),
        TemplateId.ProjectNumCreators:("ProjectNumCreators","303"),
        TemplateId.ProjectIsScripted:("ProjectIsScripted","SUS1"),
        TemplateId.ProjectIsEpisodic:("ProjectIsEpisodic","ESP1"),
        
        TemplateId.PersonFirstName:("PersonFirstName","300"),
        TemplateId.PersonLastName:("PersonLastName","304"),
        TemplateId.PersonPhoneNumber:("PersonPhoneNumber","305"),
        TemplateId.PersonEmail:("PersonEmail","306"),
        TemplateId.PersonAddress:("PersonAddress", "307"),
        TemplateId.PersonPrimaryRole:("PersonPrimaryRole","85"),
        TemplateId.PersonSecondaryRole:("PersonSecondaryRole","19b"),
        TemplateId.PersonRoleDetails:("PersonRoleDetails","23"),
        TemplateId.PersonBandName:("PersonBandName","700"),
        TemplateId.PersonBandNumMembers:("PersonBandNumMembers","701"),
        
        TemplateId.MaterialType:("MaterialType","309"),
        TemplateId.MaterialDescription:("MaterialDescription","314"),
        TemplateId.MaterialFee:("MaterialFee","310"),
        TemplateId.MaterialFeeType:("MaterialFeeType","311"),
        TemplateId.MaterialRentalStartDate:("MaterialRentalStartDate","312"),
        TemplateId.MaterialRentalEndDate:("MaterialRentalEndDate","313"),
        TemplateId.MaterialExclusiveNonExclusive:("MaterialExclusiveNonExclusive","308"),
        
        TemplateId.QuestionsCrewIsProvidingOwnSupplies:("QuestionsCrewIsProvidingOwnSupplies","231"),
        TemplateId.QuestionsCrewSuppliesDescription:("QuestionsCrewSuppliesDescription","232"),
        TemplateId.QuestionsDirectorRuntime:("QuestionsDirectorRunTime","27"),
        TemplateId.QuestionsPhotographerMinPictures:("QuestionsPhotographerMinPictures","788"),
        TemplateId.QuestionsPhotographerProjectDetails:("QuestionsPhotographerProjectDetails","789"),
        TemplateId.QuestionsPerformerCharacter:("QuestionsPerformer","301"),
        TemplateId.QuestionsPerformerPrimaryPlace:("QuestionsPerformerPrimaryPlace","302"),
        TemplateId.QuestionsPostProductionCredit:("QuestionsPostProductionCredit","791"),
        TemplateId.QuestionsProducerCredit:("QuestionsProducerCredit","790"),
        TemplateId.QuestionsTalentStageName:("QuestionsTalentStageName","24"),
        TemplateId.QuestionsTalentPreProductionStartDate:("QuestionsTalentPreProductionStartDate","16"),
        TemplateId.QuestionsTalentApproximateEndDate:("QuestionsTalentApproximateEndDate","6"),
        TemplateId.QuestionsTalentPrimaryCity:("QuestionsTalentPrimaryCity","80"),
        TemplateId.QuestionsTalentAgentDetails:("QuestionsTalentAgentDetails","83"),
        TemplateId.QuestionsTalentAdditionalConditions:("QuestionsTalentAdditionalConditions","25"),
        TemplateId.QuestionsTalentSelectEpisode:("QuestionsTalentSelectEpisode","444"),
        TemplateId.QuestionsTalentArtistFee:("QuestionsTalentArtistFee","15"),
        TemplateId.QuestionsTalentPaymentType:("QuestionsTalentPaymentType","81"),
        TemplateId.QuestionsWriterProjectApproximateRuntime:("QuestionsWriterProjectApproximateRuntime","227"),
        TemplateId.QuestionsWriterApproximateNumPagesInScript:("QuestionsWriterApproximateNumPagesInScript","228"),
        TemplateId.QuestionsWriterCredit:("QuestionsWriterCredit","229"),
        TemplateId.QuestionsWriterNumRevisionsRequired:("QuestionsWriterNumRevisionsRequired","230"),
        TemplateId.QuestionsCollaboratorRoleDescription:("QuestionsCollaboratorRoleDescription","401"),
        TemplateId.QuestionsCollaboratorCredit:("QuestionsCollaboratorCredit","402"),
        TemplateId.QuestionsNonTalentFlatFee:("QuestionsNonTalentFlatFee","777"),
        TemplateId.SignatureOwner:("SignatureOwner","90"),
        TemplateId.SignatureCounterParty:("SignatureCounterParty","90")
    ]
        
}