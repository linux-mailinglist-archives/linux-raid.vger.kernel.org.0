Return-Path: <linux-raid+bounces-4732-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E71B0D1A9
	for <lists+linux-raid@lfdr.de>; Tue, 22 Jul 2025 08:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B17E546FE5
	for <lists+linux-raid@lfdr.de>; Tue, 22 Jul 2025 06:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121CF28D85D;
	Tue, 22 Jul 2025 06:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Il1xPBu/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HnN5rOco";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Il1xPBu/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HnN5rOco"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5189B28DB5B
	for <linux-raid@vger.kernel.org>; Tue, 22 Jul 2025 06:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753164468; cv=none; b=M5+iqBMs7Ho5d8V+qzSR6A36gYjCCVXxy0A2eUbg0m7SvYTxFn44hSwflf6Np1ekd8+J/2Nntfspk62TZzJABtl9Lg9nlG1v1EkvoVj9BhAIEvPKRTLxTAhaMzipI5uXAjWIkuBCv5TG484oOlJzg0OtFiCawLkr0wmAqAI7pz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753164468; c=relaxed/simple;
	bh=Tr2kqRCEZTq9DvV7NhI6t5vE2bmiEkGXEstYtngXK5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1dfex03V3IFHrPCmr6BTb6nCQZ+1YMswNNcLPPBWJP8DCAYgRKLWa0+qr6EvFDgpSIcQlkID2E18YbE09tZlI2LYBNPGyrJ/+EwV/OOlHAYjYahTW/naYy/L54ZOYFdMKBX2mX1JsiqXrBOsZ8q0P7MqDI3ZGJSwbgCm4XCmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Il1xPBu/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnN5rOco; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Il1xPBu/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HnN5rOco; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586E81F7BA;
	Tue, 22 Jul 2025 06:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753164464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFRizxMHyKyH9ttgr7TbSy2CgKiVb6Su/8WmeCnkPU4=;
	b=Il1xPBu/JSnijwpr5a8ecdUyxfqJ51DMPwNMs2tJNIJWUE7xLQojVUZE8+bFntbhff7eH+
	yG9tU3eMA4HDRw+WbaRTBKZUfPKF6HyH3oNFHPzxqecgkxH3dJmRUxlRuDwETZgDaY7C34
	Q7pZKONDAn+HqNv3HyDUG+sxOIVMbmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753164464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFRizxMHyKyH9ttgr7TbSy2CgKiVb6Su/8WmeCnkPU4=;
	b=HnN5rOcoaWz+WwywCEDY1E2v4swlrWOw+16MEinvO/5RRXjxdA5L8VjZ33Pa6gvYuIqv0/
	GeoQYgEaqr4cupCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Il1xPBu/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=HnN5rOco
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753164464; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFRizxMHyKyH9ttgr7TbSy2CgKiVb6Su/8WmeCnkPU4=;
	b=Il1xPBu/JSnijwpr5a8ecdUyxfqJ51DMPwNMs2tJNIJWUE7xLQojVUZE8+bFntbhff7eH+
	yG9tU3eMA4HDRw+WbaRTBKZUfPKF6HyH3oNFHPzxqecgkxH3dJmRUxlRuDwETZgDaY7C34
	Q7pZKONDAn+HqNv3HyDUG+sxOIVMbmY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753164464;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nFRizxMHyKyH9ttgr7TbSy2CgKiVb6Su/8WmeCnkPU4=;
	b=HnN5rOcoaWz+WwywCEDY1E2v4swlrWOw+16MEinvO/5RRXjxdA5L8VjZ33Pa6gvYuIqv0/
	GeoQYgEaqr4cupCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4FA6132EA;
	Tue, 22 Jul 2025 06:07:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id N7VcKq8qf2ivYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 06:07:43 +0000
Message-ID: <23cec763-21e6-41d8-898b-55e3a42beeec@suse.de>
Date: Tue, 22 Jul 2025 08:07:43 +0200
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/11] md/md-bitmap: delay registration of bitmap_ops
 until creating bitmap
To: Yu Kuai <yukuai@kernel.org>, corbet@lwn.net, agk@redhat.co,
 snitzer@kernel.org, mpatocka@redhat.com, hch@lst.de, song@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yukuai3@huawei.com,
 yangerkun@huawei.com, yi.zhang@huawei.com, johnny.chenyi@huawei.com
References: <20250721171557.34587-1-yukuai@kernel.org>
 <20250721171557.34587-7-yukuai@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250721171557.34587-7-yukuai@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 586E81F7BA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/21/25 19:15, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Currently bitmap_ops is registered while allocating mddev, this is fine
> when there is only one bitmap_ops.
> 
> Delay setting bitmap_ops until creating bitmap, so that user can choose
> which bitmap to use before running the array.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   Documentation/admin-guide/md.rst |  3 ++
>   drivers/md/md.c                  | 81 ++++++++++++++++++++------------
>   2 files changed, 55 insertions(+), 29 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

