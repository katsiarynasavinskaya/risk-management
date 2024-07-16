using {riskmanagement as rm} from '../db/schema';


@path: 'service/risk'
service RiskService @(requires: 'authenticated-user') {
    entity Risks @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: [
                'READ',
                'WRITE',
                'UPDATE',
                'UPSERT',
                'DELETE'
            ],
            to   : 'RiskManager', where: 'createdBy = $user'
        }
    ])                      as projection on rm.Risks;

    annotate Risks with @odata.draft.enabled;

    entity Mitigations @(restrict: [
        {
            grant: 'READ',
            to   : 'RiskViewer'
        },
        {
            grant: '*', // Allow everything using wildcard
            to   : 'RiskManager'
        }
    ])                      as
        projection on rm.Mitigations {
            *,
            risks : redirected to Risks
        };

    annotate Mitigations with @odata.draft.enabled;


    @readonly
    entity ListOfRisks      as
        select from rm.Risks {
            ID,
            title,
            owner
        };

    @readonly
    entity BusinessPartners as projection on rm.BusinessPartners;

    function checkConnection() returns String;
}
