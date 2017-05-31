A = load 'hdfs://localhost:9000//project_data/StatewiseDistrictwisePhysicalProgress.xml' using org.apache.pig.piggybank.storage.XMLLoader('row') as (x:chararray);
B = foreach A generate REPLACE(x,'[\\n]','') as x;
 	
C = foreach B generate REGEX_EXTRACT_ALL(x,'.*(?:<State_Name>)([^<]*).*(?:<District_Name>)([^<]*).*(?:<Project_Objectives_IHHL_BPL>)([^<]*).*(?:<Project_Objectives_IHHL_APL>)([^<]*).*(?:<Project_Objectives_IHHL_TOTAL>)([^<]*).*(?:<Project_Objectives_SCW>)([^<]*).*(?:<Project_Objectives_School_Toilets>)([^<]*).*(?:<Project_Objectives_Anganwadi_Toilets>)([^<]*).*(?:<Project_Objectives_RSM>)([^<]*).*(?:<Project_Objectives_PC>)([^<]*).*(?:<Project_Performance-IHHL_BPL>)([^<]*).*(?:<Project_Performance-IHHL_APL>)([^<]*).*(?:<Project_Performance-IHHL_TOTAL>)([^<]*).*(?:<Project_Performance-SCW>)([^<]*).*(?:<Project_Performance-School_Toilets>)([^<]*).*(?:<Project_Performance-Anganwadi_Toilets>)([^<]*).*(?:<Project_Performance-RSM>)([^<]*).*(?:<Project_Performance-PC>)([^<]*).*');

 	
D = FOREACH C GENERATE FLATTEN (($0));

STORE D INTO 'hdfs://localhost:9000//project_data/xml_to_csv' USING org.apache.pig.piggybank.storage.CSVExcelStorage();










