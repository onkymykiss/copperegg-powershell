#
# Initialize-MetricGroups.ps1 contains sample code for creating a default set of metric groups.
# Copyright (c) 2012,2013 CopperEgg Corporation. All rights reserved.
#

function Initialize-MetricGroups {

  # create asp.net metric group
  $marray = @(
    @{"type"="ce_gauge";    "name"="ASPNET_Applications_Running";      "label"="ASP.NET Apps Running";          "unit"="Apps"},
    @{"type"="ce_counter";  "name"="ASPNET_Requests_Rejected";         "label"="ASP.NET Requests Rejected";            "unit"="Requests"},
    @{"type"="ce_counter";  "name"="ASPNET_Requests_Queued";           "label"="ASP.NET Requests Queued";            "unit"="Requests"},
    @{"type"="ce_gauge";    "name"="ASPNET_Worker_Processes_Running";  "label"="ASP.NET Worker Processes Running";          "unit"="Processes"},
    @{"type"="ce_counter";  "name"="ASPNET_Worker_Process_Restarts";   "label"="ASP.NET Worker Process Restarts";          "unit"="Restarts"},
    @{"type"="ce_gauge_f";  "name"="ASPNET_Request_Wait_Time";         "label"="ASP.NET Request Wait Time";           "unit"="seconds"},
    @{"type"="ce_gauge";    "name"="ASPNET_Requests_Current";          "label"="ASP.NET Requests Current";           "unit"="Requests"},
    @{"type"="ce_counter";  "name"="ASPNET_Error_Events_Raised";       "label"="ASP.NET Error Events";              "unit"="Total Errors"},
    @{"type"="ce_counter";  "name"="ASPNET_Request_Error_Events_Raised";   "label"="ASP.NET Request Error Events";      "unit"="Request Errors"},
    @{"type"="ce_counter";  "name"="ASPNET_Infrastructure_Error_Events_Raised";  "label"="ASP.NET Infrastruct Error Events";   "unit"="Infrastructure Errors"},
    @{"type"="ce_gauge";    "name"="ASPNET_Requests_In_Native_Queue";   "label"="ASP.NET Requests in Native Queue";          "unit"="Requests"}
  )
  $metricgroup_id = 'MS_ASP_NET'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "ASP.NET")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }

  # create .net clr metric group

  $marray = @(
    @{"type"="ce_counter";   "name"="NET_CLR_Exceptions_global_Number_of_Exceps_Thrown";           "label"=".NET Global Number of Exceptions";  "unit"="Exceptions"},
    @{"type"="ce_gauge_f";   "name"="NET_CLR_Exceptions_global_Number_of_Exceps_Thrown_per_sec";  "label"=".NET Global Exceptions / sec";     "unit"="Exceptions / sec"},
    @{"type"="ce_gauge";     "name"="NET_CLR_Memory_global_Number_GC_Handles";        "label"=".NET Global GC Handles";        "unit"="Handles"},
    @{"type"="ce_gauge_f";   "name"="NET_CLR_Memory_global_Allocated_Bytes_per_sec";     "label"=".NET Global Allocated Bytes / sec";      "unit"="Bytes / sec"},
    @{"type"="ce_gauge";     "name"="NET_CLR_Memory_global_Number_Total_committed_Bytes"; "label"=".NET Global Total Committed Bytes";       "unit"="Bytes"}
  )
  $metricgroup_id = 'MS_NET_CLR'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", ".NET CLR Memory")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)
    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }

  # create mssql metric group

  $marray = @(
    @{"type"="ce_gauge_f";   "name"="Buffer_Manager_Buffer_cache_hit_ratio"; "label"="MSSQL Buffer cache hit ratio";   },
    @{"type"="ce_gauge_f";   "name"="Buffer_Manager_Checkpoint_pages_per_sec";  "label"="MSSQL Checkpoint pages / sec";   "unit"="Pages / sec"},
    @{"type"="ce_gauge_f";   "name"="Buffer_Manager_Page_life_expectancy";     "label"="MSSQL Page life expectancy";    "unit"="Seconds"},
    @{"type"="ce_gauge";     "name"="General_Statistics_User_Connections";     "label"="MSSQL User Connections";    "unit"="Connections"},
    @{"type"="ce_gauge_f";   "name"="Access_Methods_Page_Splits_per_sec";       "label"="MSSQL Page Splits / sec";   "unit"="Page_splits / sec"},
    @{"type"="ce_gauge";     "name"="General_Statistics_Processes_blocked";     "label"="MSSQL Processes blocked";  "unit"="Processes"},
    @{"type"="ce_gauge_f";   "name"="SQL_Statistics_Batch_Requests_per_sec";     "label"="MSSQL Batch Requests / sec";  "unit"="Requests / sec"},
    @{"type"="ce_gauge_f";   "name"="SQL_Statistics_SQL_Compilations_per_sec";    "label"="MSSQL SQL Compilations / sec"; "unit"="Compilations / sec"},
    @{"type"="ce_gauge_f";   "name"="SQL_Statistics_SQL_Re-Compilations_per_sec"; "label"="MSSQL SQL Re-Compilations / sec"; "unit"="Re-Compilations / sec"}
  )
  $metricgroup_id = 'MS_MSSQL'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  $host_instance_hash = @{}
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    foreach($h in $hosts){
      $hosthash_array = @()
      [string[]]$instances = @()
      $instances = Find-InstanceNames $h
      if($instances -eq $null) {
        Write-CuEggLog "Found host $h with no mssql instance names!"
        Exit-Now
      } else {
        Write-CuEggLog "Found host $h with mssql instance names $instances"
        foreach($i in $instances) {
          $host_hash = @{}
          $host_hash.add("instancename",$i)
          $mspaths = @()
          $host_hash.add("mspaths",$mspaths)
          $hosthash_array += $host_hash
        }
      }
      $host_instance_hash.add($h,$hosthash_array)
    }
    Write-CuEggLog "Finished host-instance scan : $host_instance_hash"
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "SQLServer:General Statistics")
    $mgroup.add("hosts", $hosts)
    $mgroup.add("host_map", $host_instance_hash)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }

  # create Storage metric group
  $marray = @(
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Percent_Free_Space";         "label"="LogicalDisk Total % Free Space";             "unit"="Percent" },
    @{"type"="ce_gauge";     "name"="LogicalDisk_total_Current_Disk_Queue_Length";    "label"="LogicalDisk Total Current Disk Q Length";  "unit"="Items"},
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Percent_Disk_Time";            "label"="LogicalDisk Total % Disk Time";            "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Avg_Disk_Queue_Length";        "label"="LogicalDisk Total Avg Disk Q Length";      "unit"="Items"},
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Percent_Disk_Read_Time";        "label"="LogicalDisk Total % Disk Read Time";      "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Avg_Disk_Read_Queue_Length";   "label"="LogicalDisk Total Avg Disk Read Q Length";  "unit"="Items"},
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Percent_Disk_Write_Time";       "label"="LogicalDisk Total % Disk Write time";       "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="LogicalDisk_total_Avg_Disk_Write_Queue_Length";  "label"="LogicalDisk Total Avg Disk Write Q Length";  "unit"="Items"},
    @{"type"="ce_gauge";     "name"="PhysicalDisk_total_Current_Disk_Queue_Length";    "label"="PhysicalDisk Total Current Disk Q Length";    "unit"="Items"},
    @{"type"="ce_gauge_f";   "name"="PhysicalDisk_total_Percent_Disk_Time";            "label"="PhysicalDisk Total % Disk Time";            "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="PhysicalDisk_total_Avg_Disk_Queue_Length";       "label"="PhysicalDisk Total Avg Disk Q Length";       "unit"="Items"},
    @{"type"="ce_gauge_f";   "name"="PhysicalDisk_total_Percent_Disk_Read_Time";       "label"="PhysicalDisk Total % Disk Read Time";       "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="PhysicalDisk_total_Avg_Disk_Read_Queue_Length";  "label"="PhysicalDisk Total Avg Disk Read Q Length";  "unit"="Items"},
    @{"type"="ce_gauge_f";   "name"="PhysicalDisk_total_Percent_Disk_Write_Time";      "label"="PhysicalDisk Total % Disk Write time";      "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="PhysicalDisk_total_Avg_Disk_Write_Queue_Length";  "label"="PhysicalDisk Total Avg Disk Write Q Length";  "unit"="Items"}
  )
  $metricgroup_id = 'MS_Storage'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "LogicalDisk")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }

  # create System Memory metric group
  $marray = @(
    @{"type"="ce_gauge_f";   "name"="Memory_Page_Faults_per_sec";   "label"="Memory Page Faults / sec";          "unit"="Page faults / sec"  },
    @{"type"="ce_gauge";     "name"="Memory_Available_Bytes";       "label"="Memory Available Bytes";         "unit"="Bytes"},
    @{"type"="ce_gauge";     "name"="Memory_Committed_Bytes";         "label"="Memory Committed Bytes";        "unit"="Bytes"},
    @{"type"="ce_gauge";     "name"="Memory_Commit_Limit";            "label"="Memory Commit Limit";       "unit"="Bytes"},
    @{"type"="ce_gauge_f";   "name"="Memory_Write_Copies_per_sec";      "label"="Memory Write Copies / sec";      "unit"="Copies / sec"},
    @{"type"="ce_gauge_f";   "name"="Memory_Cache_Faults_per_sec";       "label"="Memory Cache Faults / sec";     "unit"="Cache faults / sec"}
  )
  $metricgroup_id = 'MS_System_Memory'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "Memory")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }

  #  create System metric group
  $marray = @(
    @{"type"="ce_gauge_f";   "name"="Paging_File_total_Percent_Usage";      "label"="Paging File Total % Usage";        "unit"="Percent" },
    @{"type"="ce_gauge_f";   "name"="Paging_File_total_Percent_Usage_Peak";    "label"="Paging File Peak Total % Usage";      "unit"="Percent"},
    @{"type"="ce_gauge_f";   "name"="System_File_Read_Operations_per_sec";     "label"="System File Read Ops / sec";      "unit"="File Reads / sec"},
    @{"type"="ce_gauge_f";   "name"="System_File_Write_Operations_per_sec";     "label"="System File Write Ops / sec";      "unit"="File Writes / sec"},
    @{"type"="ce_gauge_f";   "name"="System_File_Control_Operations_per_sec";    "label"="System File Control Ops / sec";    "unit"="File Control Ops / sec"},
    @{"type"="ce_gauge_f";   "name"="System_Context_Switches_per_sec";          "label"="System Context Switches / sec";      "unit"="Context Switches / sec"},
    @{"type"="ce_gauge_f";     "name"="System_System_Calls_per_sec";             "label"="System Calls / sec";            "unit"="Sys calls / sec"},
    @{"type"="ce_counter";   "name"="System_System_Up_Time";                      "label"="System Uptime";                "unit"="seconds"},
    @{"type"="ce_gauge";   "name"="System_Processor_Queue_Length";                "label"="System Processor Q Length";   "unit"="Queued threads"},
    @{"type"="ce_gauge";   "name"="System_Processes";                              "label"="System Processes";           "unit"="processes"},
    @{"type"="ce_gauge";   "name"="System_Threads";                                "label"="System Threads";              "unit"="Threads"},
    @{"type"="ce_gauge_f";   "name"="System_Exception_Dispatches_per_sec";         "label"="System Exceptions / Sec";     "unit"="Exceptions / sec"}
  )
  $metricgroup_id = 'MS_System'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "System")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }


  # create Web Services metric group
  $marray = @(
    @{"type"="ce_gauge";   "name"="Web_Service_total_Current_Connections";     "label"="Web Services Total Connections";        "unit"="Connections" },
    @{"type"="ce_gauge_f";   "name"="Web_Service_total_Get_Requests_per_sec";    "label"="Web Services Total GET Reqs / sec";      "unit"="Requests / sec"},
    @{"type"="ce_gauge_f";   "name"="Web_Service_total_Post_Requests_per_sec";    "label"="Web Services Total POST Reqs / sec";     "unit"="Requests / sec"},
    @{"type"="ce_gauge_f";   "name"="Web_Service_total_Put_Requests_per_sec";     "label"="Web Services Total PUT Reqs / sec";     "unit"="Requests / sec"},
    @{"type"="ce_gauge_f";   "name"="Web_Service_total_Delete_Requests_per_sec";    "label"="Web Services Total DELETE Reqs / sec";   "unit"="Requests / sec"},
    @{"type"="ce_gauge_f";   "name"="Web_Service_total_Trace_Requests_per_sec";     "label"="Web Services Total TRACE Reqs / sec";   "unit"="Requests / sec"}
  )
  $metricgroup_id = 'MS_Web_Services'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "Web Services metrics")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }


  # create UserDefined metric group
  $marray = @(
    @{"type"="ce_gauge";     "name"="LogExists";       "label"="Non-Zero if log.txt exists";  }
  )
  $metricgroup_id = 'User_Defined'
  $gname = $global:cuconfig.$metricgroup_id.group_name
  $glabel = $global:cuconfig.$metricgroup_id.group_label
  $gdash = $global:cuconfig.$metricgroup_id.dashboard
  [string[]]$hosts = @()
  $hosts = Find-IncludedHosts $metricgroup_id
  if( $hosts.length -gt 0 ){
    $global:dashes_tobuild += $gdash
    $groupcfg = New-Object PSObject -Property @{
      "name" = $gname;
      "label" = $glabel;
      "frequency" = $global:frequency;
      "is_hidden" = 0;
      "metrics" = $marray
    }
    $mgroup = @{}
    $mgroup.add("name", $gname)
    $mgroup.add("gcfg", $groupcfg)
    $mgroup.add("MS_list", "")
    $mgroup.add("hosts", $hosts)
    $global:all_metricgroups.Add( $gname, $mgroup)

    $rslt = New-MetricGroup $gname $groupcfg
    if( $rslt -ne $null ) {
      Write-CuEggLog "Successfuly created $gname"
    }
  }


 foreach( $id in $global:all_metricgroupids ) {
    $gn = $global:cuconfig.$id.group_name
    $mg = @{}
    $mg = Find-MetricGroup $gn
    if($mg -ne $null) {
      if($id.StartsWith("MS_")) {
        Write-CuEggLog "MS Perf Counter Service $id, group name $gn"
        if($id -eq 'MS_MSSQL'){
          # ms sql has to be handled separately to support multiple instance names per host
          $msp = $global:cuconfig.$id.mspaths
          $hostmap = $mg.host_map
          foreach($h in $mg.hosts){
            $hh_array = $hostmap.$h
            foreach($hh in $hh_array){
              $hh
              $iname = $hh.instancename
              Write-CuEggLog "instance name is $iname"
              [string[]]$paths = @()
              foreach($path in $msp ) {
                [string]$path = "\$iname`:$path"
                $paths = $paths + (Remove-CounterInstances($path))
              }
              $hh.mspaths = $paths
            }
          }
          foreach( $path in $msp) {
            $nam = (ConvertTo-CEName($path))
            $global:master_hash.Add($path.ToLower(),$nam)
          }
        } else {
          $msp = $global:cuconfig.$id.mspaths
          [string[]]$paths = @()
          foreach($m in $msp ) {
            $paths = $paths + (Remove-CounterInstances($m))
          }
          $mg["mspaths"] = $paths
          Write-CuEggLog "Added mpaths to metric group $gn"
          foreach( $p in $paths) {
            $nam = (ConvertTo-CEName($p))
            $global:master_hash.Add($p.ToLower(),$nam)
          }
        }
      } else {
        Write-CuEggLog "User-Defined Service $id, group name $gn"
        $ce_custom = @()
        $cus = $global:cuconfig.$id.custom
        [string[]]$vars = @()
        foreach($v in $cus ) {
          $vars += $v
        }
        $mg.add("Custom",$vars)
        Write-CuEggLog "Added custom to metric group $gn"
        # hash table entries are 'variable', 'function' for custom metrics
        foreach( $v in $vars) {
          $name = (ConvertTo-CEName($v))
          [string]$fxn = ($name + "_function")
          $global:master_hash.Add($name, $fxn)
          $ce_custom =  $ce_custom + $name
        }
        $mg["CE_Variables"] = $ce_custom
      }
    }
  }
}
