Return-Path: <linux-raid+bounces-3684-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB83A3C54F
	for <lists+linux-raid@lfdr.de>; Wed, 19 Feb 2025 17:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFEE1893F30
	for <lists+linux-raid@lfdr.de>; Wed, 19 Feb 2025 16:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF111FF1AD;
	Wed, 19 Feb 2025 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KqLhBp+w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/5bP/JhE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KqLhBp+w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/5bP/JhE"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F41FECB1
	for <linux-raid@vger.kernel.org>; Wed, 19 Feb 2025 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983049; cv=none; b=U2tPTUi61m0uFXhsIsP95wXwYB4qC0ZgYP7FfE4YI6Xfa3Q35riV7UjRegfWgZVPXqc5//Kgl+qROETlJcRaadwxse7kYPOBJiS2zhK3kwYCvzv+bJtAlmqUPjeiOTXQJpPLI4j3aIxK4v6r+v+AoGyPqnH2bI8zBmH996uUFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983049; c=relaxed/simple;
	bh=tNY6dkh1yEsy6Fl/YmMYelEun06AD50SlJe77dbwVpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EUIhZMV99VbkF7VVqtcWYLTzYw+LxoUx4YqWiET/r3H0zRDUwqyypazMjtQDA5YjyYkDsSNst9zdw7jIJbiJK+i9IgE3gtdrDU4RF57BbxTx77tDBqum4XYUx5thfX9SUq6pDVnLanD4F3j9XyoWAmuurKZRmnLchOBO/uQDE3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KqLhBp+w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/5bP/JhE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KqLhBp+w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/5bP/JhE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A95F0219CE;
	Wed, 19 Feb 2025 16:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739983046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2jyHn7yTMMH8O/+ItUH0fidGGGeUj4EmKCE7n+50rk=;
	b=KqLhBp+wAkV6VDPh8CkR+tvxiqRgp6NzzeC2n4OYtJFviJ6La1IfO6bm+miHL3F0TVJocO
	MD/8aeQiGG52mGMC+lFr6IwNqzQlh5MtlkxTVW4y/rFblWE9IpSwpWWmT+n0uqKJAyORje
	wstyum5wza7mDuiXuwlCY9h/gphaG3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739983046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2jyHn7yTMMH8O/+ItUH0fidGGGeUj4EmKCE7n+50rk=;
	b=/5bP/JhEYNLYhw9t9AXp3zq+Rq/t+rr8wwCrM70XZgP/KkZNHPVgzf30hbVGJefNebWZEx
	AL6NFq8g5bl481BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739983046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2jyHn7yTMMH8O/+ItUH0fidGGGeUj4EmKCE7n+50rk=;
	b=KqLhBp+wAkV6VDPh8CkR+tvxiqRgp6NzzeC2n4OYtJFviJ6La1IfO6bm+miHL3F0TVJocO
	MD/8aeQiGG52mGMC+lFr6IwNqzQlh5MtlkxTVW4y/rFblWE9IpSwpWWmT+n0uqKJAyORje
	wstyum5wza7mDuiXuwlCY9h/gphaG3A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739983046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2jyHn7yTMMH8O/+ItUH0fidGGGeUj4EmKCE7n+50rk=;
	b=/5bP/JhEYNLYhw9t9AXp3zq+Rq/t+rr8wwCrM70XZgP/KkZNHPVgzf30hbVGJefNebWZEx
	AL6NFq8g5bl481BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 302DF137DB;
	Wed, 19 Feb 2025 16:37:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 21LjCcYItmcLSwAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 19 Feb 2025 16:37:26 +0000
Message-ID: <1858bc0a-465b-4cf3-a95c-dbe05740adff@suse.de>
Date: Wed, 19 Feb 2025 17:37:25 +0100
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: move the block layer auto-integrity code into
 a new file
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 target-devel@vger.kernel.org
References: <20250218182207.3982214-1-hch@lst.de>
 <20250218182207.3982214-3-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250218182207.3982214-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 

On 2/18/25 19:21, Christoph Hellwig wrote:
> The code that automatically creates a integrity payload and generates /
> verifies the checksums for bios that don't have submitter-provided
> integrity payload currently sits right in the middle of the block
> integrity metadata infrastruture.  Split it into a separate file to
> make the different layers clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/Makefile             |   3 +-
>   block/bio-integrity-auto.c | 162 +++++++++++++++++++++++++++++++++++++
>   block/bio-integrity.c      | 159 ------------------------------------
>   3 files changed, 164 insertions(+), 160 deletions(-)
>   create mode 100644 block/bio-integrity-auto.c
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

