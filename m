Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037DF611632
	for <lists+linux-raid@lfdr.de>; Fri, 28 Oct 2022 17:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJ1Ppq (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Fri, 28 Oct 2022 11:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJ1Ppp (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Fri, 28 Oct 2022 11:45:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D001C8413
        for <linux-raid@vger.kernel.org>; Fri, 28 Oct 2022 08:45:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4282B21D56;
        Fri, 28 Oct 2022 15:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1666971942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j16i2xR0CkqtpqLwNlWWK/B5VG51cqCm+lpbCrHrhAU=;
        b=JekKLDd/T6QFvT4+xz3gE4MowW8MDX+fm4ZgePkO7tBZYOGLcrZFFG3am1lszvUh6Gy3DB
        a7t4D3AKIVidwJhUGf+6Uy8Dpjp2fls/WnbaYCvrln1it2czK9a0FhqCLLCGFUizCpY2fd
        NYdED5BiUhMOm5qfCw4/q0dX+NWYW/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1666971942;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j16i2xR0CkqtpqLwNlWWK/B5VG51cqCm+lpbCrHrhAU=;
        b=m+b5BhOrHtkxYtPbzV+l+in5UOZl/4lznNxhGPlPsyIQ24jfAkGRbyLQ1/0KFEBIa1/0mE
        3AiMC0FE9+NmR4Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27F1D13A6E;
        Fri, 28 Oct 2022 15:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FTmsNyT5W2MWVQAAMHmgww
        (envelope-from <colyli@suse.de>); Fri, 28 Oct 2022 15:45:40 +0000
Message-ID: <cf001ae5-0c7f-a1ba-3a80-f7edbc20b14e@suse.de>
Date:   Fri, 28 Oct 2022 23:45:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
From:   Coly Li <colyli@suse.de>
Subject: Re: [PATCH 4/9] Mdmonitor: Add helper functions
To:     Mateusz Grzonka <mateusz.grzonka@intel.com>
Cc:     jes@trained-monkey.org, linux-raid@vger.kernel.org
References: <20220907125657.12192-1-mateusz.grzonka@intel.com>
 <20220907125657.12192-5-mateusz.grzonka@intel.com>
Content-Language: en-US
In-Reply-To: <20220907125657.12192-5-mateusz.grzonka@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

On 9/7/22 8:56 PM, Mateusz Grzonka wrote:
> Add functions:
> - is_email_event(),
> - get_syslog_event_priority(),
> - sprint_event_message(),
> with kernel style comments containing more detailed descriptions.
>
> Also update event syslog priorities to be consistent with man. MoveSpare event was described in man as priority info, while implemented as warning. Move event data into a struct, so that it is passed between different functions if needed.
> Sort function declarations alphabetically and remove redundant alert() declaration.
>
> Signed-off-by: Mateusz Grzonka<mateusz.grzonka@intel.com>

Looks good to me.


Acked-by: Coly Li <colyli@suse.de>

Thanks.


Coly Li

> ---
>   Monitor.c | 230 +++++++++++++++++++++++++++++++++++++-----------------
>   1 file changed, 158 insertions(+), 72 deletions(-)
>
> diff --git a/Monitor.c b/Monitor.c
> index aa0ee047..80e43ebe 100644
> --- a/Monitor.c
> +++ b/Monitor.c
> @@ -73,10 +73,12 @@ enum event {
>   	EVENT_NEW_ARRAY,
>   	EVENT_MOVE_SPARE,
>   	EVENT_TEST_MESSAGE,
> +	__SYSLOG_PRIORITY_WARNING,
>   	EVENT_REBUILD_STARTED,
>   	EVENT_REBUILD,
>   	EVENT_REBUILD_FINISHED,
>   	EVENT_SPARES_MISSING,
> +	__SYSLOG_PRIORITY_CRITICAL,
>   	EVENT_DEVICE_DISAPPEARED,
>   	EVENT_FAIL,
>   	EVENT_FAIL_SPARE,
> @@ -100,17 +102,28 @@ mapping_t events_map[] = {
>   	{NULL, EVENT_UNKNOWN}
>   };
>   
> -static int make_daemon(char *pidfile);
> -static int check_one_sharer(int scan);
> -static void write_autorebuild_pid(void);
> -static void alert(const enum event event_enum, const unsigned int progress, const char *dev, const char *disc);
> -static int check_array(struct state *st, struct mdstat_ent *mdstat, int increments, char *prefer);
> +struct event_data {
> +	enum event event_enum;
> +	/**
> +	 * @event_name: Rebuild event name must be in form "RebuildXX", where XX is rebuild progress.
> +	 */
> +	char event_name[EVENT_NAME_MAX];
> +	char message[BUFSIZ];
> +	const char *description;
> +	const char *dev;
> +	const char *disc;
> +};
> +
>   static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist);
> -static void try_spare_migration(struct state *statelist);
> -static void link_containers_with_subarrays(struct state *list);
> +static int check_array(struct state *st, struct mdstat_ent *mdstat, int increments, char *prefer);
> +static int check_one_sharer(int scan);
>   #ifndef NO_LIBUDEV
>   static int check_udev_activity(void);
>   #endif
> +static void link_containers_with_subarrays(struct state *list);
> +static int make_daemon(char *pidfile);
> +static void try_spare_migration(struct state *statelist);
> +static void write_autorebuild_pid(void);
>   
>   int Monitor(struct mddev_dev *devlist,
>   	    char *mailaddr, char *alert_cmd,
> @@ -440,7 +453,80 @@ static void write_autorebuild_pid()
>   	}
>   }
>   
> -static void execute_alert_cmd(const char *event_name, const char *dev, const char *disc)
> +#define BASE_MESSAGE "%s event detected on md device %s"
> +#define COMPONENT_DEVICE_MESSAGE ", component device %s"
> +#define DESCRIPTION_MESSAGE ": %s"
> +/**
> + * sprint_event_message() - Writes basic message about detected event to destination ptr.
> + * @dest: message destination, should be at least the size of BUFSIZ
> + * @data: event data
> + *
> + * Return: 0 on success, 1 on error
> + */
> +static int sprint_event_message(char *dest, const struct event_data *data)
> +{
> +	if (!dest || !data)
> +		return 1;
> +
> +	if (data->disc && data->description)
> +		snprintf(dest, BUFSIZ, BASE_MESSAGE COMPONENT_DEVICE_MESSAGE DESCRIPTION_MESSAGE,
> +			 data->event_name, data->dev, data->disc, data->description);
> +	else if (data->disc)
> +		snprintf(dest, BUFSIZ, BASE_MESSAGE COMPONENT_DEVICE_MESSAGE,
> +			 data->event_name, data->dev, data->disc);
> +	else if (data->description)
> +		snprintf(dest, BUFSIZ, BASE_MESSAGE DESCRIPTION_MESSAGE,
> +			 data->event_name, data->dev, data->description);
> +	else
> +		snprintf(dest, BUFSIZ, BASE_MESSAGE, data->event_name, data->dev);
> +
> +	return 0;
> +}
> +
> +/**
> + * get_syslog_event_priority() - Determines event priority.
> + * @event_enum: event to be checked
> + *
> + * Return: LOG_CRIT, LOG_WARNING or LOG_INFO
> + */
> +static int get_syslog_event_priority(const enum event event_enum)
> +{
> +	if (event_enum > __SYSLOG_PRIORITY_CRITICAL)
> +		return LOG_CRIT;
> +	if (event_enum > __SYSLOG_PRIORITY_WARNING)
> +		return LOG_WARNING;
> +	return LOG_INFO;
> +}
> +
> +/**
> + * is_email_event() - Determines whether email for event should be sent or not.
> + * @event_enum: event to be checked
> + *
> + * Return: true if email should be sent, false otherwise
> + */
> +static bool is_email_event(const enum event event_enum)
> +{
> +	static const enum event email_events[] = {
> +	EVENT_FAIL,
> +	EVENT_FAIL_SPARE,
> +	EVENT_DEGRADED_ARRAY,
> +	EVENT_SPARES_MISSING,
> +	EVENT_TEST_MESSAGE
> +	};
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(email_events); ++i) {
> +		if (event_enum == email_events[i])
> +			return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * execute_alert_cmd() - Forks and executes command provided as alert_cmd.
> + * @data: event data
> + */
> +static void execute_alert_cmd(const struct event_data *data)
>   {
>   	int pid = fork();
>   
> @@ -452,12 +538,16 @@ static void execute_alert_cmd(const char *event_name, const char *dev, const cha
>   		pr_err("Cannot fork to execute alert command");
>   		break;
>   	case 0:
> -		execl(info.alert_cmd, info.alert_cmd, event_name, dev, disc, NULL);
> +		execl(info.alert_cmd, info.alert_cmd, data->event_name, data->dev, data->disc, NULL);
>   		exit(2);
>   	}
>   }
>   
> -static void send_event_email(const char *event_name, const char *dev, const char *disc)
> +/**
> + * send_event_email() - Sends an email about event detected by monitor.
> + * @data: event data
> + */
> +static void send_event_email(const struct event_data *data)
>   {
>   	FILE *mp, *mdstat;
>   	char buf[BUFSIZ];
> @@ -475,15 +565,9 @@ static void send_event_email(const char *event_name, const char *dev, const char
>   	else
>   		fprintf(mp, "From: %s monitoring <root>\n", Name);
>   	fprintf(mp, "To: %s\n", info.mailaddr);
> -	fprintf(mp, "Subject: %s event on %s:%s\n\n", event_name, dev, info.hostname);
> -	fprintf(mp, "This is an automatically generated mail message. \n");
> -	fprintf(mp, "A %s event had been detected on md device %s.\n\n", event_name, dev);
> -
> -	if (disc && disc[0] != ' ')
> -		fprintf(mp,
> -			"It could be related to component device %s.\n\n", disc);
> -	if (disc && disc[0] == ' ')
> -		fprintf(mp, "Extra information:%s.\n\n", disc);
> +	fprintf(mp, "Subject: %s event on %s:%s\n\n", data->event_name, data->dev, info.hostname);
> +	fprintf(mp, "This is an automatically generated mail message.\n");
> +	fprintf(mp, "%s\n", data->message);
>   
>   	mdstat = fopen("/proc/mdstat", "r");
>   	if (!mdstat) {
> @@ -499,58 +583,60 @@ static void send_event_email(const char *event_name, const char *dev, const char
>   	pclose(mp);
>   }
>   
> -static void log_event_to_syslog(const enum event event_enum, const char *event_name, const char *dev, const char *disc)
> +/**
> + * log_event_to_syslog() - Logs an event into syslog.
> + * @data: event data
> + */
> +static void log_event_to_syslog(const struct event_data *data)
>   {
>   	int priority;
> -	/* Log at a different severity depending on the event.
> -	 *
> -	 * These are the critical events:  */
> -	if (event_enum == EVENT_FAIL ||
> -	    event_enum == EVENT_DEGRADED_ARRAY ||
> -	    event_enum == EVENT_DEVICE_DISAPPEARED)
> -		priority = LOG_CRIT;
> -	/* Good to know about, but are not failures: */
> -	else if (event_enum == EVENT_REBUILD ||
> -		 event_enum == EVENT_MOVE_SPARE ||
> -		 event_enum == EVENT_SPARES_MISSING)
> -		priority = LOG_WARNING;
> -	/* Everything else: */
> -	else
> -		priority = LOG_INFO;
> -
> -	if (disc && disc[0] != ' ')
> -		syslog(priority,
> -		       "%s event detected on md device %s, component device %s",
> -		       event_name, dev, disc);
> -	else if (disc)
> -		syslog(priority, "%s event detected on md device %s: %s", event_name, dev, disc);
> -	else
> -		syslog(priority, "%s event detected on md device %s", event_name, dev);
> +
> +	priority = get_syslog_event_priority(data->event_enum);
> +
> +	syslog(priority, "%s\n", data->message);
>   }
>   
> -static void alert(const enum event event_enum, const unsigned int progress, const char *dev, const char *disc)
> +/**
> + * alert() - Alerts about the monitor event.
> + * @event_enum: event to be sent
> + * @description: event description
> + * @progress: rebuild progress
> + * @dev: md device name
> + * @disc: component device
> + *
> + * If needed function executes alert command, sends an email or logs event to syslog.
> + */
> +static void alert(const enum event event_enum, const char *description, const uint8_t progress,
> +		  const char *dev, const char *disc)
>   {
> -	char event_name[EVENT_NAME_MAX];
> +	struct event_data data = {.dev = dev, .disc = disc, .description = description};
> +
> +	if (!dev)
> +		return;
>   
>   	if (event_enum == EVENT_REBUILD) {
> -		snprintf(event_name, sizeof(event_name), "%s%02d",
> +		snprintf(data.event_name, sizeof(data.event_name), "%s%02d",
>   			 map_num_s(events_map, EVENT_REBUILD), progress);
>   	} else {
> -		snprintf(event_name, sizeof(event_name), "%s", map_num_s(events_map, event_enum));
> +		snprintf(data.event_name, sizeof(data.event_name), "%s", map_num_s(events_map, event_enum));
>   	}
>   
> -	if (info.alert_cmd)
> -		execute_alert_cmd(event_name, dev, disc);
> +	data.event_enum = event_enum;
>   
> -	if (info.mailaddr && (event_enum == EVENT_FAIL ||
> -			      event_enum == EVENT_TEST_MESSAGE ||
> -			      event_enum == EVENT_SPARES_MISSING ||
> -			      event_enum == EVENT_DEGRADED_ARRAY)) {
> -		send_event_email(event_name, dev, disc);
> +	if (sprint_event_message(data.message, &data) != 0) {
> +		pr_err("Cannot create event message.\n");
> +		return;
>   	}
> +	pr_err("%s\n", data.message);
> +
> +	if (info.alert_cmd)
> +		execute_alert_cmd(&data);
> +
> +	if (info.mailaddr && is_email_event(event_enum))
> +		send_event_email(&data);
>   
>   	if (info.dosyslog)
> -		log_event_to_syslog(event_enum, event_name, dev, disc);
> +		log_event_to_syslog(&data);
>   }
>   
>   static int check_array(struct state *st, struct mdstat_ent *mdstat,
> @@ -575,7 +661,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   	unsigned long redundancy_only_flags = 0;
>   
>   	if (info.test)
> -		alert(EVENT_TEST_MESSAGE, 0, dev, NULL);
> +		alert(EVENT_TEST_MESSAGE, NULL, 0, dev, NULL);
>   
>   	retval = 0;
>   
> @@ -624,7 +710,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   	 */
>   	if (sra->array.level == 0 || sra->array.level == -1) {
>   		if (!st->err && !st->from_config)
> -			alert(EVENT_DEVICE_DISAPPEARED, 0, dev, " Wrong-Level");
> +			alert(EVENT_DEVICE_DISAPPEARED, "Wrong-Level", 0, dev, NULL);
>   		st->err++;
>   		goto out;
>   	}
> @@ -641,7 +727,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   		st->percent = RESYNC_NONE;
>   		new_array = 1;
>   		if (!is_container)
> -			alert(EVENT_NEW_ARRAY, 0, st->devname, NULL);
> +			alert(EVENT_NEW_ARRAY, NULL, 0, st->devname, NULL);
>   	}
>   
>   	if (st->utime == array.utime && st->failed == sra->array.failed_disks &&
> @@ -654,20 +740,20 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   	}
>   	if (st->utime == 0 && /* new array */
>   	    mse->pattern && strchr(mse->pattern, '_') /* degraded */)
> -		alert(EVENT_DEGRADED_ARRAY, 0, dev, NULL);
> +		alert(EVENT_DEGRADED_ARRAY, NULL, 0, dev, NULL);
>   
>   	if (st->utime == 0 && /* new array */ st->expected_spares > 0 &&
>   	    sra->array.spare_disks < st->expected_spares)
> -		alert(EVENT_SPARES_MISSING, 0, dev, NULL);
> +		alert(EVENT_SPARES_MISSING, NULL, 0, dev, NULL);
>   	if (st->percent < 0 && st->percent != RESYNC_UNKNOWN &&
>   	    mse->percent >= 0)
> -		alert(EVENT_REBUILD_STARTED, 0, dev, NULL);
> +		alert(EVENT_REBUILD_STARTED, NULL, 0, dev, NULL);
>   	if (st->percent >= 0 && mse->percent >= 0 &&
>   	    (mse->percent / increments) > (st->percent / increments)) {
>   		if((mse->percent / increments) == 0)
> -			alert(EVENT_REBUILD_STARTED, 0, dev, NULL);
> +			alert(EVENT_REBUILD_STARTED, NULL, 0, dev, NULL);
>   		else
> -			alert(EVENT_REBUILD, mse->percent, dev, NULL);
> +			alert(EVENT_REBUILD, NULL, mse->percent, dev, NULL);
>   	}
>   
>   	if (mse->percent == RESYNC_NONE && st->percent >= 0) {
> @@ -680,9 +766,9 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   			snprintf(cnt, sizeof(cnt),
>   				 " mismatches found: %d (on raid level %d)",
>   				 sra->mismatch_cnt, sra->array.level);
> -			alert(EVENT_REBUILD_FINISHED, 0, dev, cnt);
> +			alert(EVENT_REBUILD_FINISHED, NULL, 0, dev, cnt);
>   		} else
> -			alert(EVENT_REBUILD_FINISHED, 0, dev, NULL);
> +			alert(EVENT_REBUILD_FINISHED, NULL, 0, dev, NULL);
>   	}
>   	st->percent = mse->percent;
>   
> @@ -736,14 +822,14 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   		change = newstate ^ st->devstate[i];
>   		if (st->utime && change && !st->err && !new_array) {
>   			if ((st->devstate[i]&change) & (1 << MD_DISK_SYNC))
> -				alert(EVENT_FAIL, 0, dev, dv);
> +				alert(EVENT_FAIL, NULL, 0, dev, dv);
>   			else if ((newstate & (1 << MD_DISK_FAULTY)) &&
>   				 (disc.major || disc.minor) &&
>   				 st->devid[i] == makedev(disc.major,
>   							 disc.minor))
> -				alert(EVENT_FAIL_SPARE, 0, dev, dv);
> +				alert(EVENT_FAIL_SPARE, NULL, 0, dev, dv);
>   			else if ((newstate&change) & (1 << MD_DISK_SYNC))
> -				alert(EVENT_SPARE_ACTIVE, 0, dev, dv);
> +				alert(EVENT_SPARE_ACTIVE, NULL, 0, dev, dv);
>   		}
>   		st->devstate[i] = newstate;
>   		st->devid[i] = makedev(disc.major, disc.minor);
> @@ -767,7 +853,7 @@ static int check_array(struct state *st, struct mdstat_ent *mdstat,
>   
>    disappeared:
>   	if (!st->err && !is_container)
> -		alert(EVENT_DEVICE_DISAPPEARED, 0, dev, NULL);
> +		alert(EVENT_DEVICE_DISAPPEARED, NULL, 0, dev, NULL);
>   	st->err++;
>   	goto out;
>   }
> @@ -827,7 +913,7 @@ static int add_new_arrays(struct mdstat_ent *mdstat, struct state **statelist)
>   				st->parent_devnm[0] = 0;
>   			*statelist = st;
>   			if (info.test)
> -				alert(EVENT_TEST_MESSAGE, 0, st->devname, NULL);
> +				alert(EVENT_TEST_MESSAGE, NULL, 0, st->devname, NULL);
>   			new_found = 1;
>   		}
>   	return new_found;
> @@ -1050,7 +1136,7 @@ static void try_spare_migration(struct state *statelist)
>   				if (devid > 0 &&
>   				    move_spare(from->devname, to->devname,
>   					       devid)) {
> -					alert(EVENT_MOVE_SPARE, 0, to->devname, from->devname);
> +					alert(EVENT_MOVE_SPARE, NULL, 0, to->devname, from->devname);
>   					break;
>   				}
>   			}


