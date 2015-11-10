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
            }
<#if (executionData.succeededNodeListString)?has_content>
    ,{
      "title": "Succeeded Nodes",
      "value": "${executionData.succeededNodeListString}",
      "short": true
    }
</#if>
<#if (executionData.failedNodeListString)?has_content>
    ,{
      "title": "Failed Nodes",
      "value": "${executionData.failedNodeListString}",
      "short": true
    }
</#if>
]
      }
   ]
}

