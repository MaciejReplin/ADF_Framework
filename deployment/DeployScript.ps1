$env:Environment = 'uat'
$ResourceGroupName = 'rg-dataplatform-idm-'+$env:Environment+'-weu'    
$DataFactoryName = 'adf-dp-idm-'+$env:Environment+'-weu'                        #Target data factory name
$Location = 'westeurope' # location
$RootFolder = 'C:\GIT\BeeSafe\Metadata\dataplatform-idm-adf\' #Root folder from which we take data to deploy
$Stage  = $RootFolder + 'deployment\config_'+$env:Environment+'.json' #Location of config file UAT

$opt = New-AdfPublishOption
$opt.Excludes.Add('pipeline.Deploy*',"")  #We excude deploy objcts pipelines, they are used only in dev
$opt.Excludes.Add('*.*WIP',"")    #WE exclude all WIP objects, they should have WIP in name!

# -FilterFilePath ".\deployment\rules.txt" You can define rules for loading in separate file, or even load from selected folder only
$opt.DeleteNotInSource = $false  #You can delete objects not in soruce



Publish-AdfV2FromJson -RootFolder "$RootFolder" -ResourceGroupName "$ResourceGroupName" -DataFactoryName "$DataFactoryName" -Location "$Location" -Stage "$Stage" -Option $opt
