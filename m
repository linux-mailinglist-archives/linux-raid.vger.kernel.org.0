Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8632B1A618A
	for <lists+linux-raid@lfdr.de>; Mon, 13 Apr 2020 04:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbgDMCeP (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Sun, 12 Apr 2020 22:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727520AbgDMCeP (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Sun, 12 Apr 2020 22:34:15 -0400
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B53C0A3BE0
        for <linux-raid@vger.kernel.org>; Sun, 12 Apr 2020 19:34:15 -0700 (PDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 324F3AC61;
        Mon, 13 Apr 2020 02:34:13 +0000 (UTC)
Subject: Re: [PATCH] Monitor: improve check_one_sharer() for checking
 duplicated process
To:     Zhong Lidong <lidong.zhong@suse.com>
Cc:     jes@trained-monkey.org, linux-raid@vger.kernel.org,
        Shinkichi Yamazaki <shinkichi.yamazaki@suse.com>
References: <20200410162446.6292-1-colyli@suse.de>
 <f62b9338-10d4-c9d5-3d8f-a0ac432b11e2@suse.com>
From:   Coly Li <colyli@suse.de>
Autocrypt: addr=colyli@suse.de; keydata=
 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
Message-ID: <d89ad1f8-4393-5ae8-fd6b-1ee255fd38be@suse.de>
Date:   Mon, 13 Apr 2020 10:34:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f62b9338-10d4-c9d5-3d8f-a0ac432b11e2@suse.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 2020/4/13 09:47, Zhong Lidong wrote:
> On 4/11/20 12:24 AM, Coly Li wrote:
>> When running mdadm monitor with scan mode, only one autorebuild process
>> is allowed. check_one_sharer() checks duplicated process by following
>> steps,
>> 1) Read autorebuild.pid file,
>>    - if file does not exist, no duplicated process, go to 3).
>>    - if file exists, continue to next step.
>> 2) Read pid number from autorebuild.pid file, then check procfs pid
>>    directory /proc/<PID>,
>>    - if the directory does not exist, no duplicated process, go to 3)
>>    - if the directory exists, print error message for duplicated process
>>      and exit this mdadm.
>> 3) Write current pid into autorebuild.pid file, continue to monitor in
>>    scan mode.
>>
>> The problem for the above step 2) is, if after system reboots and
>> another different process happens to have exact same pid number which
>> autorebuild.pid file records, check_one_sharer() will treat it as a
>> duplicated mdadm process and returns error with message "Only one
>> autorebuild process allowed in scan mode, aborting".
>>
>> This patch tries to fix the above same-pid-but-different-process issue
>> by one more step to check the process command name,
>> 1) Read autorebuild.pid file
>>    - if file does not exist, no duplicated process, go to 4).
>>    - if file exists, continue to next step.
>> 2) Read pid number from autorebuild.pid file, then check procfs file
>>    comm with the specific pid directory /proc/<PID>/comm
>>    - if the file does not exit, it means the directory /proc/<PID> does
>>      not exist, go to 4)
>>    - if the file exits, continue next step
>> 3) Read process command name from /proc/<PIC>/comm, compare the command
>>    name with "mdadm" process name,
>>    - if not equal, no duplicated process, goto 4)
>>    - if strings are equal, print error message for duplicated process
>>      and exit this mdadm.
>> 4) Write current pid into autorebuild.pid file, continue to monitor in
>>    scan mode.
>>
>> Now check_one_sharer() returns error for duplicated process only when
>> the recorded pid from autorebuild.pid exists, and the process has exact
>> same command name as "mdadm".
>>
> 
> Consider another corner case: what if the recorded pid from
> autorebuild.pid is actually used by other mdadm command, such as "mdadm
> --wait"? It shouldn't report error now.
> 

Hi Lidong,

This is a try-best effort, if there happens to be another mdadm process
has exact same pid number, this mdadm in scan mode has to fail.

There is no perfect method to prevent duplicated process, e.g. rename
the mdadm program to another name, this patch is not able to detect it
as duplicated process neither.

This is an improvement for current check_one_sharer(), not a silver bullet.

Thank.

Coly Li




> 
>> Reported-by: Shinkichi Yamazaki <shinkichi.yamazaki@suse.com>
>> Signed-off-by: Coly Li <colyli@suse.de>
>> ---
>>  Monitor.c | 32 ++++++++++++++++++++------------
>>  1 file changed, 20 insertions(+), 12 deletions(-)
>>
>> diff --git a/Monitor.c b/Monitor.c
>> index b527165..2d6b3b9 100644
>> --- a/Monitor.c
>> +++ b/Monitor.c
>> @@ -301,26 +301,34 @@ static int make_daemon(char *pidfile)
>>  
>>  static int check_one_sharer(int scan)
>>  {
>> -	int pid, rv;
>> +	int pid;
>> +	FILE *comm_fp;
>>  	FILE *fp;
>> -	char dir[20];
>> +	char comm_path[100];
>>  	char path[100];
>> -	struct stat buf;
>> +	char comm[20];
>> +
>>  	sprintf(path, "%s/autorebuild.pid", MDMON_DIR);
>>  	fp = fopen(path, "r");
>>  	if (fp) {
>>  		if (fscanf(fp, "%d", &pid) != 1)
>>  			pid = -1;
>> -		sprintf(dir, "/proc/%d", pid);
>> -		rv = stat(dir, &buf);
>> -		if (rv != -1) {
>> -			if (scan) {
>> -				pr_err("Only one autorebuild process allowed in scan mode, aborting\n");
>> -				fclose(fp);
>> -				return 1;
>> -			} else {
>> -				pr_err("Warning: One autorebuild process already running.\n");
>> +		snprintf(comm_path, sizeof(comm_path),
>> +			 "/proc/%d/comm", pid);
>> +		comm_fp = fopen(comm_path, "r");
>> +		if (comm_fp) {
>> +			if (fscanf(comm_fp, "%s", comm) &&
>> +			    strncmp(basename(comm), Name, strlen(Name)) == 0) {
>> +				if (scan) {
>> +					pr_err("Only one autorebuild process allowed in scan mode, aborting\n");
>> +					fclose(comm_fp);
>> +					fclose(fp);
>> +					return 1;
>> +				} else {
>> +					pr_err("Warning: One autorebuild process already running.\n");
>> +				}
>>  			}
>> +			fclose(comm_fp);
>>  		}
>>  		fclose(fp);
>>  	}
>>

