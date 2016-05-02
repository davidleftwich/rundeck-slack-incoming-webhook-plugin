<#if executionData.job.group??>
    <#assign jobName="${executionData.job.group} / ${executionData.job.name}">
<#else>
    <#assign jobName="${executionData.job.name}">
</#if>
<#assign message="<${executionData.href}|Execution #${executionData.id}> of job <${executionData.job.href}|${jobName}>">
<#if trigger == "start">
    <#assign state="Started">
<#elseif trigger == "failure">
    <#assign state="Failed">
<#else>
    <#assign state="Succeeded">
</#if>
<#if (executionData.succeededNodeListString)?has_content>
    <#assign succeededNodeList=executionData.succeededNodeListString?split(',')>
</#if>
<#if (executionData.failedNodeListString)?has_content>
    <#assign failedNodeList=executionData.failedNodeListString?split(',')>
</#if>
<#if (executionData.context.option.VersionSelect)?has_content>
    <#assign version=executionData.context.option.VersionSelect>
</#if>

{
   "attachments":[
      {
         "fallback":"${state}: ${message}",
         "pretext":"${message}",
         "color":"${color}",
         "fields":[
            {
               "title":"Status",
               "value":"${state}",
               "short":true
            },
            {
               "title":"Version",
               "value":"${version}",
               "short":true
            }
           ]}
<#if (succeededNodeList)?has_content>
  <#list succeededNodeList?chunk(100) as snodes>
      ,{
         "fields":[
            {
               "title": "Succeeded Nodes",
               "value": "${snodes?join(", ")}",
               "short": false
            }
       ]}
  </#list>
</#if>
<#if (failedNodeList)?has_content>
  <#list failedNodeList?chunk(100) as fnodes>
      ,{
         "fields":[
            {
               "title": "Failed Nodes",
               "value": "${fnodes?join(", ")}",
               "short": false
            }
       ]}
  </#list>
</#if>
]
      }
