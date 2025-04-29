Return-Path: <linux-raid+bounces-4080-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5F2AA0345
	for <lists+linux-raid@lfdr.de>; Tue, 29 Apr 2025 08:26:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD273A808F
	for <lists+linux-raid@lfdr.de>; Tue, 29 Apr 2025 06:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E09522F3B0;
	Tue, 29 Apr 2025 06:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="db0HSSEs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XqL+um24";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="db0HSSEs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XqL+um24"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6417C21B
	for <linux-raid@vger.kernel.org>; Tue, 29 Apr 2025 06:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907951; cv=none; b=XA7yDToJE23sjlIEIsN6ByBy5BhcRc82IvvRPlboqytXNdAXlAclYKjCQi6trJcaBlmcnoaDSK6LLnHEC21Od/wKMfBkRINSqzygSv07rFvdw6VME9PjrSRonl+L+MB+2ddXR4DY5j63v6YLLke4/BKPR1zX++vIGChSFeX0YWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907951; c=relaxed/simple;
	bh=jBiD/YapoGW177IbLkYB3vVFsc7jriKE2rlPnMCWMtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Apsj/eic8AFIjsgvjSoXzuN8WI4DYQUAs6KN7+2Ane6PCpIxgRdzET0jewDC10Du+RlORWUmVR+vdA1LYR6ND8GWd6yBIUhBq9no91E8SJwqPoX276t3kfnwPlOR72fk9I2b866SaQ2RN8XybUmuyoAh51DsYxunYP+yMw1LD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=db0HSSEs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XqL+um24; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=db0HSSEs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XqL+um24; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B1A881FB5A;
	Tue, 29 Apr 2025 06:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745907947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN9dbtdUFDq27tKWn7MFJvi8tb3eggILMwkZ2BFXns4=;
	b=db0HSSEsriJkqk5vmANZ/pDBcBPZXfVYIRNo7QW+1wY9CwhVXZn/dVcCentd7waTrAyBsB
	FiZ9ir6gpmcnBwhGH3FODgkj5qo2Oy/EZ13LbCzC5t/HvGIKSqrUKrzNI+6MfVfMFtzclq
	AF3eUb6CHVa1q41rYQXjTWf/iFQudSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745907947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN9dbtdUFDq27tKWn7MFJvi8tb3eggILMwkZ2BFXns4=;
	b=XqL+um24uR8A+ecFos13OEc5mNRaeZ8ag/q7BKd9UAn0Ig6irJRIlNSXYAKxaWaIanhYLT
	DsF3Du9G4slvbWCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=db0HSSEs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=XqL+um24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745907947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN9dbtdUFDq27tKWn7MFJvi8tb3eggILMwkZ2BFXns4=;
	b=db0HSSEsriJkqk5vmANZ/pDBcBPZXfVYIRNo7QW+1wY9CwhVXZn/dVcCentd7waTrAyBsB
	FiZ9ir6gpmcnBwhGH3FODgkj5qo2Oy/EZ13LbCzC5t/HvGIKSqrUKrzNI+6MfVfMFtzclq
	AF3eUb6CHVa1q41rYQXjTWf/iFQudSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745907947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN9dbtdUFDq27tKWn7MFJvi8tb3eggILMwkZ2BFXns4=;
	b=XqL+um24uR8A+ecFos13OEc5mNRaeZ8ag/q7BKd9UAn0Ig6irJRIlNSXYAKxaWaIanhYLT
	DsF3Du9G4slvbWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E7E1913931;
	Tue, 29 Apr 2025 06:25:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ay/zNupwEGhqXwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 29 Apr 2025 06:25:46 +0000
Message-ID: <3b69424a-5901-49f2-a613-5c2b38fff764@suse.de>
Date: Tue, 29 Apr 2025 08:25:46 +0200
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/9] block: reuse part_in_flight_rw for part_in_flight
To: Yu Kuai <yukuai1@huaweicloud.com>, hch@infradead.org, axboe@kernel.dk,
 xni@redhat.com, agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com,
 song@kernel.org, yukuai3@huawei.com, cl@linux.com, nadav.amit@gmail.com,
 ubizjak@gmail.com, akpm@linux-foundation.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250427082928.131295-1-yukuai1@huaweicloud.com>
 <20250427082928.131295-3-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250427082928.131295-3-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B1A881FB5A
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_TO(0.00)[huaweicloud.com,infradead.org,kernel.dk,redhat.com,kernel.org,huawei.com,linux.com,gmail.com,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huawei.com:email,suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 4/27/25 10:29, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> They are almost identical, to make code cleaner.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   block/genhd.c | 24 +++++++++---------------
>   1 file changed, 9 insertions(+), 15 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

