$title = 'RDO Lobbies'
$question = 'Do you want to be in a public lobby?'

$choices = New-Object Collections.ObjectModel.Collection[Management.Automation.Host.ChoiceDescription]
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&Yes'))
$choices.Add((New-Object Management.Automation.Host.ChoiceDescription -ArgumentList '&No'))

$decision = $Host.UI.PromptForChoice($title, $question, $choices, 1)
if ($decision -eq 0) {
    if (Test-Path -Path "C:\Program Files\Epic Games\RedDeadRedemption2\x64\boot_launcher_flow.ymt") {
        Remove-Item "C:\Program Files\Epic Games\RedDeadRedemption2\x64\boot_launcher_flow.ymt"
    }
    if (Test-Path -Path "C:\Program Files\Epic Games\RedDeadRedemption2\x64\data\startup.meta") {
        Remove-Item "C:\Program Files\Epic Games\RedDeadRedemption2\x64\data\startup.meta"
    }
    Write-Output "`n`nYou need to restart RDR to return to the public lobbies.`n`n"
}
else {
    $LobbyName = Read-Host "Enter a lobby name"
    @"
<?xml version="1.0" encoding="UTF-8"?>
<!--$LobbyName-->
<rage__fwuiFlowBlock>
<ID>boot_flow</ID>
<EntryPoints>
<Item>
<ID>default_entry</ID>
<Target>boot_screen_host.account_picker_activity_sentinel.account_picker_wrapper</Target>
</Item>
<Item>
<ID>bye</ID>
<Target>boot_screen_host.legal_screen_activity_sentinel.stinger</Target>
</Item>
<Item>
<ID>sign_out</ID>
<Target>boot_screen_host.account_picker_activity_sentinel.account_picker_wrapper</Target>
</Item>
</EntryPoints>
<ExitPoints>
<Item>
<ID>exit</ID>
</Item>
</ExitPoints>
<FlowRoot>
<ID>input_context_switch</ID>
<State type="StateSetInputContext">
<ContextType>BOOT_FLOW</ContextType>
</State>
<Children>
<Item>
<ID>boot_screen_host</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/boot_screen_host</SceneName>
<GCOnRemove value="True" />
</State>
<Children>
<Item>
<ID>account_picker_activity_sentinel</ID>
<State type="rage__StateActivitySentinel">
<ActivityID>account_picker</ActivityID>
</State>
<Children>
<Item>
<ID>account_picker_wrapper</ID>
<State type="StateAccountPicker" />
<LinkMap>
<Item key="next">
<Target>account_picker</Target>
</Item>
<Item key="failed">
<Target>^.^.profile_flow_activity_sentinel.wait_for_profile</Target>
</Item>
<Item key="profile_changed">
<Target>^.^.profile_flow_activity_sentinel.wait_for_profile</Target>
</Item>
<Item key="profile_unchanged">
<Target>^.^.profile_flow_activity_sentinel.wait_for_profile</Target>
</Item>
</LinkMap>
<Children>
<Item>
<ID>account_picker</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/account_picker/account_picker_with_background</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
<EnterAnimation>boot_screen_fade_in</EnterAnimation>
<ExitAnimation>boot_screen_fade_out</ExitAnimation>
</State>
</Item>
</Children>
</Item>
</Children>
</Item>
<Item>
<ID>legal_screen_activity_sentinel</ID>
<State type="rage__StateActivitySentinel">
<ActivityID>legal_screen</ActivityID>
</State>
<Children>
<Item>
<ID>stinger</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/legal_splash/stinger</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_legal">
<Target>^.stinger</Target>
</Item>
</LinkMap>
</Item>
<Item>
<ID>legal_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/legal_splash/legal_splash</SceneName>
<EnterAnimation>legal_splash_animation</EnterAnimation>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="next">
<Target>^.^.profile_flow_activity_sentinel.wait_for_profile</Target>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
<Item>
<ID>profile_flow_activity_sentinel</ID>
<State type="rage__StateActivitySentinel">
<ActivityID>profile_flow</ActivityID>
</State>
<Children>
<Item>
<ID>wait_for_profile</ID>
<State type="StateWaitForProfileLoad" />
<LinkMap>
<Item key="next">
<Target>^.language_screen_wrapper</Target>
</Item>
<Item key="exit">
<Target>exit</Target>
<LinkInfo>LINK_TO_EXTERNAL</LinkInfo>
</Item>
<Item key="yes">
<Target>exit</Target>
<LinkInfo>LINK_TO_EXTERNAL</LinkInfo>
</Item>
</LinkMap>
</Item>
<Item>
<ID>language_screen_wrapper</ID>
<State type="StateLanguageSelect" />
<LinkMap>
<Item key="next">
<Target>language_screen</Target>
</Item>
<Item key="failed"platform="x64|orbis">
<Target>^.hdr_enabled_screen_wrapper</Target>
</Item>
</LinkMap>
<Children>
<Item>
<ID>language_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/language_selection</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_next_screen"platform="x64|orbis">
<Target>^.^.hdr_enabled_screen_wrapper</Target>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
<Item>
<ID>hdr_enabled_screen_wrapper</ID>
<State type="StateStartupSettingSelection">
<SettingPath>
<pathElements>
<Item>display</Item>
<Item>hdr</Item>
</pathElements>
</SettingPath>
</State>
<LinkMap>
<Item key="next">
<Target>hdr_enabled_screen</Target>
</Item>
<Item key="failed">
<Target>^.brightness_screen_wrapper</Target>
</Item>
</LinkMap>
<Children>
<Item>
<ID>hdr_enabled_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/hdr_enabled_screen</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_next_screen">
<Target>^.^.brightness_screen_wrapper</Target>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
<Item>
<ID>brightness_screen_wrapper</ID>
<State type="StateGammaCalibration">
<MovieFilename>PAUSE_MENU_CALIBRATION</MovieFilename>
</State>
<LinkMap>
<Item key="next">
<Target>brightness_screen</Target>
</Item>
<Item key="failed">
<Target>^.hdr_screen_wrapper</Target>
</Item>
</LinkMap>
<Children>
<Item>
<ID>brightness_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/brightness_calibration</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_next_screen">
<Target>^.^.hdr_screen_wrapper</Target>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
<Item>
<ID>hdr_screen_wrapper</ID>
<State type="StateHDRCalibration">
<MovieFilename>UIOBJECT_SCENE_GENERIC</MovieFilename>
</State>
<LinkMap>
<Item key="next">
<Target>hdr_screen</Target>
</Item>
<Item key="failed">
<Target>^.subtitles_screen_wrapper</Target>
</Item>
</LinkMap>
<Children>
<Item>
<ID>hdr_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/hdr</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_next_screen">
<Target>^.^.subtitles_screen_wrapper</Target>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
<Item>
<ID>subtitles_screen_wrapper</ID>
<State type="StateSubtitlesSelect">
<SettingPath>
<pathElements>
<Item>display</Item>
<Item>hud</Item>
<Item>subtitles</Item>
</pathElements>
</SettingPath>
</State>
<LinkMap>
<Item key="next">
<Target>subtitles_screen</Target>
</Item>
<Item key="failed">
<Target>^.audio_screen_wrapper</Target>
</Item>
</LinkMap>
<Children>
<Item>
<ID>subtitles_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/subtitles_selection</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_next_screen">
<Target>^.^.audio_screen_wrapper</Target>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
<Item>
<ID>audio_screen_wrapper</ID>
<State type="StateStartupSettingSelection">
<SettingPath>
<pathElements>
<Item>audio</Item>
<Item>speakerOutput</Item>
</pathElements>
</SettingPath>
</State>
<LinkMap>
<Item key="next">
<Target>audio_screen</Target>
</Item>
<Item key="failed">
<Target>exit</Target>
<LinkInfo>LINK_TO_EXTERNAL</LinkInfo>
</Item>
</LinkMap>
<Children>
<Item>
<ID>audio_screen</ID>
<State type="StateUIObjectStreamedSceneHost">
<SceneName>boot_flow/audio_selection</SceneName>
<ParentPath>boot_screen_host.PAN_Content</ParentPath>
</State>
<LinkMap>
<Item key="to_next_screen">
<Target>exit</Target>
<LinkInfo>LINK_TO_EXTERNAL</LinkInfo>
</Item>
</LinkMap>
</Item>
</Children>
</Item>
</Children>
</Item>
</Children>
</Item>
</Children>
</FlowRoot>
</rage__fwuiFlowBlock>
<!--$LobbyName-->
"@ | Out-File -FilePath "C:\Program Files\Epic Games\RedDeadRedemption2\x64\boot_launcher_flow.ymt"

    @"
<?xml version="1.0" encoding="UTF-8"?>
<!--$LobbyName-->
<CDataFileMgr__ContentsOfDataFileXml>
 <disabledFiles />
 <includedXmlFiles itemType="CDataFileMgr__DataFileArray" />
 <includedDataFiles />
 <dataFiles itemType="CDataFileMgr__DataFile">
  <Item>
   <filename>platform:/data/cdimages/scaleform_platform_pc.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
  <Item>
   <filename>platform:/data/ui/value_conversion.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
  <Item>
   <filename>platform:/data/ui/widgets.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
  <Item>
   <filename>platform:/textures/ui/ui_photo_stickers.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
  <Item>
   <filename>platform:/textures/ui/ui_platform.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
  <Item>
   <filename>platform:/data/ui/stylesCatalog</filename>
   <fileType>aWeaponizeDisputants</fileType> <!-- collision -->
  </Item>
  <Item>
   <filename>platform:/data/cdimages/scaleform_frontend.rpf</filename>
   <fileType>RPF_FILE_PRE_INSTALL</fileType>
  </Item>
  <Item>
   <filename>platform:/textures/ui/ui_startup_textures.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
  <Item>
   <filename>platform:/data/ui/startup_data.rpf</filename>
   <fileType>RPF_FILE</fileType>
  </Item>
	<Item>
		<filename>platform:/boot_launcher_flow.#mt</filename>
		<fileType>STREAMING_FILE</fileType>
		<registerAs>boot_flow/boot_launcher_flow</registerAs>
		<overlay value="false" />
		<patchFile value="false" />
	</Item>
 </dataFiles>
 <contentChangeSets itemType="CDataFileMgr__ContentChangeSet" />
 <patchFiles />
</CDataFileMgr__ContentsOfDataFileXml>                               
<!--$LobbyName-->
"@ | Out-File -FilePath "C:\Program Files\Epic Games\RedDeadRedemption2\x64\data\startup.meta"

    Write-Output "`n`nYou need to restart RDR to join your lobby named '$LobbyName'.`n`n"
}


Read-Host -Prompt "Press Enter to exit"