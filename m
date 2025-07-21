Return-Path: <linux-raid+bounces-4711-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6540FB0BC6E
	for <lists+linux-raid@lfdr.de>; Mon, 21 Jul 2025 08:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A315179C8B
	for <lists+linux-raid@lfdr.de>; Mon, 21 Jul 2025 06:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCBD26FD97;
	Mon, 21 Jul 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HWkPN9kJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q001gH7M";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HWkPN9kJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Q001gH7M"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D079B26E712
	for <linux-raid@vger.kernel.org>; Mon, 21 Jul 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753078849; cv=none; b=kZncTLWgvo/3YwTP7aN6sNQYPtCPfXGMr8vZQ7cZ+1Nyh0cxqW9lHoLt54hnna6piEqtxHSD1b8OYVzi4wI0CDT8WwJQIPmftaP3ZKti5ojGP4DbNg82pEUI/VXwBXZqCmiBqjXsr7OcS1+bvAtG6NeWCbYW2mE/Rd9wg3Pq77k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753078849; c=relaxed/simple;
	bh=F7oEslX3EfCeN6kNU1YNWQRW8jltabIop7jimRLwcwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LaGNXDETr6iBAkC4A529HooGCTInbAS9So1lWCCnE+pLnXuBObgZ0HahPnm6CF9lZT/mMrvboZiBNEi0kFLG8KlZURa5SSjaly4L9lol7yQYH7BAQwtt2CYyDsM2T8938ModN6QDm0Tzy6BedPRtBTnHr+GlC91MMJlJs10hpgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HWkPN9kJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q001gH7M; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HWkPN9kJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Q001gH7M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 179CB218FC;
	Mon, 21 Jul 2025 06:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753078844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoMLAgqaH9EIXGoOBLwb6SPWqyeCAjaei48q8VqTFJA=;
	b=HWkPN9kJTodMgZupv9Wx0ouESIKpB82Gy3uHPWCEikvopgECwW3PzGn30fbIKFvScVDIAV
	fTondPH/58ayTwIHs1Ox4jO49Keba+MIvZoXc+NOBGW1RsgJenGtEZapOZIHgFnApL1MD8
	FJwxr/OfL/Yp/DHgMUXO9OWV4vEXqXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753078844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoMLAgqaH9EIXGoOBLwb6SPWqyeCAjaei48q8VqTFJA=;
	b=Q001gH7MS3/JpyBI8VlfJEWhNZJDIdrvo2QdZCAP3xc8vF3ZgtNBnaQLlvUzTVxkyQ1c1U
	BGL5w6UlWSGC2dDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753078844; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoMLAgqaH9EIXGoOBLwb6SPWqyeCAjaei48q8VqTFJA=;
	b=HWkPN9kJTodMgZupv9Wx0ouESIKpB82Gy3uHPWCEikvopgECwW3PzGn30fbIKFvScVDIAV
	fTondPH/58ayTwIHs1Ox4jO49Keba+MIvZoXc+NOBGW1RsgJenGtEZapOZIHgFnApL1MD8
	FJwxr/OfL/Yp/DHgMUXO9OWV4vEXqXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753078844;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LoMLAgqaH9EIXGoOBLwb6SPWqyeCAjaei48q8VqTFJA=;
	b=Q001gH7MS3/JpyBI8VlfJEWhNZJDIdrvo2QdZCAP3xc8vF3ZgtNBnaQLlvUzTVxkyQ1c1U
	BGL5w6UlWSGC2dDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 319EC13A88;
	Mon, 21 Jul 2025 06:20:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7snCjvcfWgUSwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Jul 2025 06:20:43 +0000
Message-ID: <04ba77bb-464d-4b98-91e6-4225204ae679@suse.de>
Date: Mon, 21 Jul 2025 08:20:42 +0200
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] md/md-llbitmap: introduce new lockless bitmap
To: Yu Kuai <yukuai1@huaweicloud.com>, corbet@lwn.net, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 dm-devel@lists.linux.dev, linux-raid@vger.kernel.org, yi.zhang@huawei.com,
 yangerkun@huawei.com, johnny.chenyi@huawei.com
References: <20250718092336.3346644-1-yukuai1@huaweicloud.com>
 <20250718092336.3346644-12-yukuai1@huaweicloud.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250718092336.3346644-12-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 7/18/25 11:23, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> Redundant data is used to enhance data fault tolerance, and the storage
> method for redundant data vary depending on the RAID levels. And it's
> important to maintain the consistency of redundant data.
> 
> Bitmap is used to record which data blocks have been synchronized and which
> ones need to be resynchronized or recovered. Each bit in the bitmap
> represents a segment of data in the array. When a bit is set, it indicates
> that the multiple redundant copies of that data segment may not be
> consistent. Data synchronization can be performed based on the bitmap after
> power failure or readding a disk. If there is no bitmap, a full disk
> synchronization is required.
> 
> Key Features:
> 
>   - IO fastpath is lockless, if user issues lots of write IO to the same
>   bitmap bit in a short time, only the first write have additional overhead
>   to update bitmap bit, no additional overhead for the following writes;
>   - support only resync or recover written data, means in the case creating
>   new array or replacing with a new disk, there is no need to do a full disk
>   resync/recovery;
> 
> Key Concept:
> 
>   - State Machine:
> 
> Each bit is one byte, contain 6 difference state, see llbitmap_state. And
> there are total 8 differenct actions, see llbitmap_action, can change state:
> 
> llbitmap state machine: transitions between states
> 
> |           | Startwrite | Startsync | Endsync | Abortsync|
> | --------- | ---------- | --------- | ------- | -------  |
> | Unwritten | Dirty      | x         | x       | x        |
> | Clean     | Dirty      | x         | x       | x        |
> | Dirty     | x          | x         | x       | x        |
> | NeedSync  | x          | Syncing   | x       | x        |
> | Syncing   | x          | Syncing   | Dirty   | NeedSync |
> 
> |           | Reload   | Daemon | Discard   | Stale     |
> | --------- | -------- | ------ | --------- | --------- |
> | Unwritten | x        | x      | x         | x         |
> | Clean     | x        | x      | Unwritten | NeedSync  |
> | Dirty     | NeedSync | Clean  | Unwritten | NeedSync  |
> | NeedSync  | x        | x      | Unwritten | x         |
> | Syncing   | NeedSync | x      | Unwritten | NeedSync  |
> 
> Typical scenarios:
> 
> 1) Create new array
> All bits will be set to Unwritten by default, if --assume-clean is set,
> all bits will be set to Clean instead.
> 
> 2) write data, raid1/raid10 have full copy of data, while raid456 doesn't and
> rely on xor data
> 
> 2.1) write new data to raid1/raid10:
> Unwritten --StartWrite--> Dirty
> 
> 2.2) write new data to raid456:
> Unwritten --StartWrite--> NeedSync
> 
> Because the initial recover for raid456 is skipped, the xor data is not build
> yet, the bit must set to NeedSync first and after lazy initial recover is
> finished, the bit will finially set to Dirty(see 5.1 and 5.4);
> 
> 2.3) cover write
> Clean --StartWrite--> Dirty
> 
> 3) daemon, if the array is not degraded:
> Dirty --Daemon--> Clean
> 
> For degraded array, the Dirty bit will never be cleared, prevent full disk
> recovery while readding a removed disk.
> 
> 4) discard
> {Clean, Dirty, NeedSync, Syncing} --Discard--> Unwritten
> 
> 5) resync and recover
> 
> 5.1) common process
> NeedSync --Startsync--> Syncing --Endsync--> Dirty --Daemon--> Clean
> 
> 5.2) resync after power failure
> Dirty --Reload--> NeedSync
> 
> 5.3) recover while replacing with a new disk
> By default, the old bitmap framework will recover all data, and llbitmap
> implement this by a new helper, see llbitmap_skip_sync_blocks:
> 
> skip recover for bits other than dirty or clean;
> 
> 5.4) lazy initial recover for raid5:
> By default, the old bitmap framework will only allow new recover when there
> are spares(new disk), a new recovery flag MD_RECOVERY_LAZY_RECOVER is add
> to perform raid456 lazy recover for set bits(from 2.2).
> 
> Bitmap IO:
> 
>   - Chunksize
> 
> The default bitmap size is 128k, incluing 1k bitmap super block, and
> the default size of segment of data in the array each bit(chunksize) is 64k,
> and chunksize will adjust to twice the old size each time if the total number
> bits is not less than 127k.(see llbitmap_init)
> 
>   - READ
> 
> While creating bitmap, all pages will be allocated and read for llbitmap,
> there won't be read afterwards
> 
>   - WRITE
> 
> WRITE IO is divided into logical_block_size of the array, the dirty state
> of each block is tracked independently, for example:
> 
> each page is 4k, contain 8 blocks; each block is 512 bytes contain 512 bit;
> 
> | page0 | page1 | ... | page 31 |
> |       |
> |        \-----------------------\
> |                                |
> | block0 | block1 | ... | block 8|
> |        |
> |         \-----------------\
> |                            |
> | bit0 | bit1 | ... | bit511 |
> 
>  From IO path, if one bit is changed to Dirty or NeedSync, the corresponding
> subpage will be marked dirty, such block must write first before the IO is
> issued. This behaviour will affect IO performance, to reduce the impact, if
> multiple bits are changed in the same block in a short time, all bits in this
> block will be changed to Dirty/NeedSync, so that there won't be any overhead
> until daemon clears dirty bits.
> 
> Dirty Bits syncronization:
> 
> IO fast path will set bits to dirty, and those dirty bits will be cleared
> by daemon after IO is done. llbitmap_page_ctl is used to synchronize between
> IO path and daemon;
> 
> IO path:
>   1) try to grab a reference, if succeed, set expire time after 5s and return;
>   2) if failed to grab a reference, wait for daemon to finish clearing dirty
>   bits;
> 
> Daemon(Daemon will be waken up every daemon_sleep seconds):
> For each page:
>   1) check if page expired, if not skip this page; for expired page:
>   2) suspend the page and wait for inflight write IO to be done;
>   3) change dirty page to clean;
>   4) resume the page;
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   Documentation/admin-guide/md.rst |   16 +
>   drivers/md/Kconfig               |   11 +
>   drivers/md/Makefile              |    1 +
>   drivers/md/md-bitmap.c           |    9 -
>   drivers/md/md-bitmap.h           |   31 +-
>   drivers/md/md-llbitmap.c         | 1564 ++++++++++++++++++++++++++++++
>   drivers/md/md.c                  |    6 +
>   drivers/md/md.h                  |    4 +-
>   8 files changed, 1630 insertions(+), 12 deletions(-)
>   create mode 100644 drivers/md/md-llbitmap.c
> 
> diff --git a/Documentation/admin-guide/md.rst b/Documentation/admin-guide/md.rst
> index 03a9f5025f99..c471006641c1 100644
> --- a/Documentation/admin-guide/md.rst
> +++ b/Documentation/admin-guide/md.rst
> @@ -387,6 +387,8 @@ All md devices contain:
>            No bitmap
>        bitmap
>            The default internal bitmap
> +     llbitmap
> +         The lockless internal bitmap
>   
>   If bitmap_type is not none, then additional bitmap attributes will be
>   created after md device KOBJ_CHANGE event.
> @@ -447,6 +449,20 @@ If bitmap_type is bitmap, then the md device will also contain:
>        once the array becomes non-degraded, and this fact has been
>        recorded in the metadata.
>   
> +If bitmap_type is llbitmap, then the md device will also contain:
> +
> +  llbitmap/bits
> +     This is readonly, show status of bitmap bits, the number of each
> +     value.
> +
> +  llbitmap/metadata
> +     This is readonly, show bitmap metadata, include chunksize, chunkshift,
> +     chunks, offset and daemon_sleep.
> +
> +  llbitmap/daemon_sleep
> +     This is readwrite, time in seconds that daemon function will be
> +     triggered to clear dirty bits.
> +
>   As component devices are added to an md array, they appear in the ``md``
>   directory as new directories named::
>   
I guess this should go with the paragraph about adding new attributes
for KOBJ_CHANGE.

> diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
> index f913579e731c..07c19b2182ca 100644
> --- a/drivers/md/Kconfig
> +++ b/drivers/md/Kconfig
> @@ -52,6 +52,17 @@ config MD_BITMAP
>   
>   	  If unsure, say Y.
>   
> +config MD_LLBITMAP
> +	bool "MD RAID lockless bitmap support"
> +	depends on BLK_DEV_MD
> +	help
> +	  If you say Y here, support for the lockless write intent bitmap will
> +	  be enabled.
> +
> +	  Note, this is an experimental feature.
> +
> +	  If unsure, say N.
> +
>   config MD_AUTODETECT
>   	bool "Autodetect RAID arrays during kernel boot"
>   	depends on BLK_DEV_MD=y
> diff --git a/drivers/md/Makefile b/drivers/md/Makefile
> index 2e18147a9c40..5a51b3408b70 100644
> --- a/drivers/md/Makefile
> +++ b/drivers/md/Makefile
> @@ -29,6 +29,7 @@ dm-zoned-y	+= dm-zoned-target.o dm-zoned-metadata.o dm-zoned-reclaim.o
>   
>   md-mod-y	+= md.o
>   md-mod-$(CONFIG_MD_BITMAP)	+= md-bitmap.o
> +md-mod-$(CONFIG_MD_LLBITMAP)	+= md-llbitmap.o
>   raid456-y	+= raid5.o raid5-cache.o raid5-ppl.o
>   linear-y       += md-linear.o
>   
> diff --git a/drivers/md/md-bitmap.c b/drivers/md/md-bitmap.c
> index 0eb3774f372d..7ec33f9dd256 100644
> --- a/drivers/md/md-bitmap.c
> +++ b/drivers/md/md-bitmap.c
> @@ -34,15 +34,6 @@
>   #include "md-bitmap.h"
>   #include "md-cluster.h"
>   
> -#define BITMAP_MAJOR_LO 3
> -/* version 4 insists the bitmap is in little-endian order
> - * with version 3, it is host-endian which is non-portable
> - * Version 5 is currently set only for clustered devices
> - */
> -#define BITMAP_MAJOR_HI 4
> -#define BITMAP_MAJOR_CLUSTERED 5
> -#define	BITMAP_MAJOR_HOSTENDIAN 3
> -
>   /*
>    * in-memory bitmap:
>    *
> diff --git a/drivers/md/md-bitmap.h b/drivers/md/md-bitmap.h
> index 5f41724cbcd8..b42a28fa83a0 100644
> --- a/drivers/md/md-bitmap.h
> +++ b/drivers/md/md-bitmap.h
> @@ -9,10 +9,26 @@
>   
>   #define BITMAP_MAGIC 0x6d746962
>   
> +/*
> + * version 3 is host-endian order, this is deprecated and not used for new
> + * array
> + */
> +#define BITMAP_MAJOR_LO		3
> +#define BITMAP_MAJOR_HOSTENDIAN	3
> +/* version 4 is little-endian order, the default value */
> +#define BITMAP_MAJOR_HI		4
> +/* version 5 is only used for cluster */
> +#define BITMAP_MAJOR_CLUSTERED	5
> +/* version 6 is only used for lockless bitmap */
> +#define BITMAP_MAJOR_LOCKLESS	6
> +
>   /* use these for bitmap->flags and bitmap->sb->state bit-fields */
>   enum bitmap_state {
> -	BITMAP_STALE	   = 1,  /* the bitmap file is out of date or had -EIO */
> +	BITMAP_STALE	   = 1, /* the bitmap file is out of date or had -EIO */
>   	BITMAP_WRITE_ERROR = 2, /* A write error has occurred */
> +	BITMAP_FIRST_USE   = 3, /* llbitmap is just created */
> +	BITMAP_CLEAN       = 4, /* llbitmap is created with assume_clean */
> +	BITMAP_DAEMON_BUSY = 5, /* llbitmap daemon is not finished after daemon_sleep */
>   	BITMAP_HOSTENDIAN  =15,
>   };
>   
> @@ -166,4 +182,17 @@ static inline void md_bitmap_exit(void)
>   }
>   #endif
>   
> +#ifdef CONFIG_MD_LLBITMAP
> +int md_llbitmap_init(void);
> +void md_llbitmap_exit(void);
> +#else
> +static inline int md_llbitmap_init(void)
> +{
> +	return 0;
> +}
> +static inline void md_llbitmap_exit(void)
> +{
> +}
> +#endif
> +
>   #endif
> diff --git a/drivers/md/md-llbitmap.c b/drivers/md/md-llbitmap.c
> new file mode 100644
> index 000000000000..7830b75a5876
> --- /dev/null
> +++ b/drivers/md/md-llbitmap.c
> @@ -0,0 +1,1564 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <linux/blkdev.h>
> +#include <linux/module.h>
> +#include <linux/errno.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/timer.h>
> +#include <linux/sched.h>
> +#include <linux/list.h>
> +#include <linux/file.h>
> +#include <linux/seq_file.h>
> +#include <trace/events/block.h>
> +
> +#include "md.h"
> +#include "md-bitmap.h"
> +
> +/*
> + * #### Background
> + *
> + * Redundant data is used to enhance data fault tolerance, and the storage
> + * method for redundant data vary depending on the RAID levels. And it's
> + * important to maintain the consistency of redundant data.
> + *
> + * Bitmap is used to record which data blocks have been synchronized and which
> + * ones need to be resynchronized or recovered. Each bit in the bitmap
> + * represents a segment of data in the array. When a bit is set, it indicates
> + * that the multiple redundant copies of that data segment may not be
> + * consistent. Data synchronization can be performed based on the bitmap after
> + * power failure or readding a disk. If there is no bitmap, a full disk
> + * synchronization is required.
> + *
> + * #### Key Features
> + *
> + *  - IO fastpath is lockless, if user issues lots of write IO to the same
> + *  bitmap bit in a short time, only the first write have additional overhead
> + *  to update bitmap bit, no additional overhead for the following writes;
> + *  - support only resync or recover written data, means in the case creating
> + *  new array or replacing with a new disk, there is no need to do a full disk
> + *  resync/recovery;
> + *
> + * #### Key Concept
> + *
> + * ##### State Machine
> + *
> + * Each bit is one byte, contain 6 difference state, see llbitmap_state. And
> + * there are total 8 differenct actions, see llbitmap_action, can change state:
> + *
> + * llbitmap state machine: transitions between states
> + *
> + * |           | Startwrite | Startsync | Endsync | Abortsync|
> + * | --------- | ---------- | --------- | ------- | -------  |
> + * | Unwritten | Dirty      | x         | x       | x        |
> + * | Clean     | Dirty      | x         | x       | x        |
> + * | Dirty     | x          | x         | x       | x        |
> + * | NeedSync  | x          | Syncing   | x       | x        |
> + * | Syncing   | x          | Syncing   | Dirty   | NeedSync |
> + *
> + * |           | Reload   | Daemon | Discard   | Stale     |
> + * | --------- | -------- | ------ | --------- | --------- |
> + * | Unwritten | x        | x      | x         | x         |
> + * | Clean     | x        | x      | Unwritten | NeedSync  |
> + * | Dirty     | NeedSync | Clean  | Unwritten | NeedSync  |
> + * | NeedSync  | x        | x      | Unwritten | x         |
> + * | Syncing   | NeedSync | x      | Unwritten | NeedSync  |
> + *
> + * Typical scenarios:
> + *
> + * 1) Create new array
> + * All bits will be set to Unwritten by default, if --assume-clean is set,
> + * all bits will be set to Clean instead.
> + *
> + * 2) write data, raid1/raid10 have full copy of data, while raid456 doesn't and
> + * rely on xor data
> + *
> + * 2.1) write new data to raid1/raid10:
> + * Unwritten --StartWrite--> Dirty
> + *
> + * 2.2) write new data to raid456:
> + * Unwritten --StartWrite--> NeedSync
> + *
> + * Because the initial recover for raid456 is skipped, the xor data is not build
> + * yet, the bit must set to NeedSync first and after lazy initial recover is
> + * finished, the bit will finially set to Dirty(see 5.1 and 5.4);
> + *
> + * 2.3) cover write
> + * Clean --StartWrite--> Dirty
> + *
> + * 3) daemon, if the array is not degraded:
> + * Dirty --Daemon--> Clean
> + *
> + * For degraded array, the Dirty bit will never be cleared, prevent full disk
> + * recovery while readding a removed disk.
> + *
> + * 4) discard
> + * {Clean, Dirty, NeedSync, Syncing} --Discard--> Unwritten
> + *
> + * 5) resync and recover
> + *
> + * 5.1) common process
> + * NeedSync --Startsync--> Syncing --Endsync--> Dirty --Daemon--> Clean
> + *
> + * 5.2) resync after power failure
> + * Dirty --Reload--> NeedSync
> + *
> + * 5.3) recover while replacing with a new disk
> + * By default, the old bitmap framework will recover all data, and llbitmap
> + * implement this by a new helper, see llbitmap_skip_sync_blocks:
> + *
> + * skip recover for bits other than dirty or clean;
> + *
> + * 5.4) lazy initial recover for raid5:
> + * By default, the old bitmap framework will only allow new recover when there
> + * are spares(new disk), a new recovery flag MD_RECOVERY_LAZY_RECOVER is add
> + * to perform raid456 lazy recover for set bits(from 2.2).
> + *
> + * ##### Bitmap IO
> + *
> + * ##### Chunksize
> + *
> + * The default bitmap size is 128k, incluing 1k bitmap super block, and
> + * the default size of segment of data in the array each bit(chunksize) is 64k,
> + * and chunksize will adjust to twice the old size each time if the total number
> + * bits is not less than 127k.(see llbitmap_init)
> + *
> + * ##### READ
> + *
> + * While creating bitmap, all pages will be allocated and read for llbitmap,
> + * there won't be read afterwards
> + *
> + * ##### WRITE
> + *
> + * WRITE IO is divided into logical_block_size of the array, the dirty state
> + * of each block is tracked independently, for example:
> + *
> + * each page is 4k, contain 8 blocks; each block is 512 bytes contain 512 bit;
> + *
> + * | page0 | page1 | ... | page 31 |
> + * |       |
> + * |        \-----------------------\
> + * |                                |
> + * | block0 | block1 | ... | block 8|
> + * |        |
> + * |         \-----------------\
> + * |                            |
> + * | bit0 | bit1 | ... | bit511 |
> + *
> + * From IO path, if one bit is changed to Dirty or NeedSync, the corresponding
> + * subpage will be marked dirty, such block must write first before the IO is
> + * issued. This behaviour will affect IO performance, to reduce the impact, if
> + * multiple bits are changed in the same block in a short time, all bits in this
> + * block will be changed to Dirty/NeedSync, so that there won't be any overhead
> + * until daemon clears dirty bits.
> + *
> + * ##### Dirty Bits syncronization
> + *
> + * IO fast path will set bits to dirty, and those dirty bits will be cleared
> + * by daemon after IO is done. llbitmap_page_ctl is used to synchronize between
> + * IO path and daemon;
> + *
> + * IO path:
> + *  1) try to grab a reference, if succeed, set expire time after 5s and return;
> + *  2) if failed to grab a reference, wait for daemon to finish clearing dirty
> + *  bits;
> + *
> + * Daemon(Daemon will be waken up every daemon_sleep seconds):
> + * For each page:
> + *  1) check if page expired, if not skip this page; for expired page:
> + *  2) suspend the page and wait for inflight write IO to be done;
> + *  3) change dirty page to clean;
> + *  4) resume the page;
> + */
> +
> +#define BITMAP_DATA_OFFSET 1024
> +
> +/* 64k is the max IO size of sync IO for raid1/raid10 */
> +#define MIN_CHUNK_SIZE (64 * 2)
> +

Hmm? Which one is it?
Comment says 'max IO size', but it's called 'MIN_CHUNK_SIZE'...

> +/* By default, daemon will be waken up every 30s */
> +#define DEFAULT_DAEMON_SLEEP 30
> +
> +/*
> + * Dirtied bits that have not been accessed for more than 5s will be cleared
> + * by daemon.
> + */
> +#define BARRIER_IDLE 5
> +

Should this be changeable, too?

> +enum llbitmap_state {
> +	/* No valid data, init state after assemble the array */
> +	BitUnwritten = 0,
> +	/* data is consistent */
> +	BitClean,
> +	/* data will be consistent after IO is done, set directly for writes */
> +	BitDirty,
> +	/*
> +	 * data need to be resynchronized:
> +	 * 1) set directly for writes if array is degraded, prevent full disk
> +	 * synchronization after readding a disk;
> +	 * 2) reassemble the array after power failure, and dirty bits are
> +	 * found after reloading the bitmap;
> +	 * 3) set for first write for raid5, to build initial xor data lazily
> +	 */
> +	BitNeedSync,
> +	/* data is synchronizing */
> +	BitSyncing,
> +	BitStateCount,
> +	BitNone = 0xff,
> +};
> +
> +enum llbitmap_action {
> +	/* User write new data, this is the only action from IO fast path */
> +	BitmapActionStartwrite = 0,
> +	/* Start recovery */
> +	BitmapActionStartsync,
> +	/* Finish recovery */
> +	BitmapActionEndsync,
> +	/* Failed recovery */
> +	BitmapActionAbortsync,
> +	/* Reassemble the array */
> +	BitmapActionReload,
> +	/* Daemon thread is trying to clear dirty bits */
> +	BitmapActionDaemon,
> +	/* Data is deleted */
> +	BitmapActionDiscard,
> +	/*
> +	 * Bitmap is stale, mark all bits in addition to BitUnwritten to
> +	 * BitNeedSync.
> +	 */
> +	BitmapActionStale,
> +	BitmapActionCount,
> +	/* Init state is BitUnwritten */
> +	BitmapActionInit,
> +};
> +
> +enum llbitmap_page_state {
> +	LLPageFlush = 0,
> +	LLPageDirty,
> +};
> +
> +struct llbitmap_page_ctl {
> +	char *state;
> +	struct page *page;
> +	unsigned long expire;
> +	unsigned long flags;
> +	wait_queue_head_t wait;
> +	struct percpu_ref active;
> +	/* Per block size dirty state, maximum 64k page / 1 sector = 128 */
> +	unsigned long dirty[];
> +};
> +
> +struct llbitmap {
> +	struct mddev *mddev;
> +	struct llbitmap_page_ctl **pctl;
> +
> +	unsigned int nr_pages;
> +	unsigned int io_size;
> +	unsigned int blocks_per_page;
> +
> +	/* shift of one chunk */
> +	unsigned long chunkshift;
> +	/* size of one chunk in sector */
> +	unsigned long chunksize;
> +	/* total number of chunks */
> +	unsigned long chunks;
> +	unsigned long last_end_sync;
> +	/* fires on first BitDirty state */
> +	struct timer_list pending_timer;
> +	struct work_struct daemon_work;
> +
> +	unsigned long flags;
> +	__u64	events_cleared;
> +
> +	/* for slow disks */
> +	atomic_t behind_writes;
> +	wait_queue_head_t behind_wait;
> +};
> +
> +struct llbitmap_unplug_work {
> +	struct work_struct work;
> +	struct llbitmap *llbitmap;
> +	struct completion *done;
> +};
> +
> +static struct workqueue_struct *md_llbitmap_io_wq;
> +static struct workqueue_struct *md_llbitmap_unplug_wq;
> +
> +static char state_machine[BitStateCount][BitmapActionCount] = {
> +	[BitUnwritten] = {
> +		[BitmapActionStartwrite]	= BitDirty,
> +		[BitmapActionStartsync]		= BitNone,
> +		[BitmapActionEndsync]		= BitNone,
> +		[BitmapActionAbortsync]		= BitNone,
> +		[BitmapActionReload]		= BitNone,
> +		[BitmapActionDaemon]		= BitNone,
> +		[BitmapActionDiscard]		= BitNone,
> +		[BitmapActionStale]		= BitNone,
> +	},
> +	[BitClean] = {
> +		[BitmapActionStartwrite]	= BitDirty,
> +		[BitmapActionStartsync]		= BitNone,
> +		[BitmapActionEndsync]		= BitNone,
> +		[BitmapActionAbortsync]		= BitNone,
> +		[BitmapActionReload]		= BitNone,
> +		[BitmapActionDaemon]		= BitNone,
> +		[BitmapActionDiscard]		= BitUnwritten,
> +		[BitmapActionStale]		= BitNeedSync,
> +	},
> +	[BitDirty] = {
> +		[BitmapActionStartwrite]	= BitNone,
> +		[BitmapActionStartsync]		= BitNone,
> +		[BitmapActionEndsync]		= BitNone,
> +		[BitmapActionAbortsync]		= BitNone,
> +		[BitmapActionReload]		= BitNeedSync,
> +		[BitmapActionDaemon]		= BitClean,
> +		[BitmapActionDiscard]		= BitUnwritten,
> +		[BitmapActionStale]		= BitNeedSync,
> +	},
> +	[BitNeedSync] = {
> +		[BitmapActionStartwrite]	= BitNone,
> +		[BitmapActionStartsync]		= BitSyncing,
> +		[BitmapActionEndsync]		= BitNone,
> +		[BitmapActionAbortsync]		= BitNone,
> +		[BitmapActionReload]		= BitNone,
> +		[BitmapActionDaemon]		= BitNone,
> +		[BitmapActionDiscard]		= BitUnwritten,
> +		[BitmapActionStale]		= BitNone,
> +	},
> +	[BitSyncing] = {
> +		[BitmapActionStartwrite]	= BitNone,
> +		[BitmapActionStartsync]		= BitSyncing,
> +		[BitmapActionEndsync]		= BitDirty,
> +		[BitmapActionAbortsync]		= BitNeedSync,
> +		[BitmapActionReload]		= BitNeedSync,
> +		[BitmapActionDaemon]		= BitNone,
> +		[BitmapActionDiscard]		= BitUnwritten,
> +		[BitmapActionStale]		= BitNeedSync,
> +	},
> +};
> +
> +static enum llbitmap_state llbitmap_read(struct llbitmap *llbitmap, loff_t pos)
> +{
> +	unsigned int idx;
> +	unsigned int offset;
> +
> +	pos += BITMAP_DATA_OFFSET;
> +	idx = pos >> PAGE_SHIFT;
> +	offset = offset_in_page(pos);
> +
> +	return llbitmap->pctl[idx]->state[offset];
> +}
> +
> +/* set all the bits in the subpage as dirty */
> +static void llbitmap_infect_dirty_bits(struct llbitmap *llbitmap,
> +				       struct llbitmap_page_ctl *pctl,
> +				       unsigned int bit, unsigned int offset)
> +{
> +	bool level_456 = raid_is_456(llbitmap->mddev);
> +	unsigned int io_size = llbitmap->io_size;
> +	int pos;
> +
> +	for (pos = bit * io_size; pos < (bit + 1) * io_size; pos++) {
> +		if (pos == offset)
> +			continue;
> +
> +		switch (pctl->state[pos]) {
> +		case BitUnwritten:
> +			pctl->state[pos] = level_456 ? BitNeedSync : BitDirty;
> +			break;
> +		case BitClean:
> +			pctl->state[pos] = BitDirty;
> +			break;
> +		};
> +	}
> +
> +}
> +
> +static void llbitmap_set_page_dirty(struct llbitmap *llbitmap, int idx,
> +				    int offset)
> +{
> +	struct llbitmap_page_ctl *pctl = llbitmap->pctl[idx];
> +	unsigned int io_size = llbitmap->io_size;
> +	int bit = offset / io_size;
> +	int pos;
> +
> +	if (!test_bit(LLPageDirty, &pctl->flags))
> +		set_bit(LLPageDirty, &pctl->flags);
> +
> +	/*
> +	 * The subpage usually contains a total of 512 bits. If any single bit
> +	 * within the subpage is marked as dirty, the entire sector will be
> +	 * written. To avoid impacting write performance, when multiple bits
> +	 * within the same sector are modified within a short time frame, all
> +	 * bits in the sector will be collectively marked as dirty at once.
> +	 */

How short is the 'short timeframe'?
Is this the BARRIER_IDLE setting?
Please clarify.

> +	if (test_and_set_bit(bit, pctl->dirty)) {
> +		llbitmap_infect_dirty_bits(llbitmap, pctl, bit, offset);
> +		return;
> +	}
> +
> +	for (pos = bit * io_size; pos < (bit + 1) * io_size; pos++) {
> +		if (pos == offset)
> +			continue;
> +		if (pctl->state[pos] == BitDirty ||
> +		    pctl->state[pos] == BitNeedSync) {
> +			llbitmap_infect_dirty_bits(llbitmap, pctl, bit, offset);
> +			return;
> +		}
> +	}
> +}
> +
> +static void llbitmap_write(struct llbitmap *llbitmap, enum llbitmap_state state,
> +			   loff_t pos)
> +{
> +	unsigned int idx;
> +	unsigned int offset;
> +
> +	pos += BITMAP_DATA_OFFSET;
> +	idx = pos >> PAGE_SHIFT;
> +	offset = offset_in_page(pos);
> +
> +	llbitmap->pctl[idx]->state[offset] = state;
> +	if (state == BitDirty || state == BitNeedSync)
> +		llbitmap_set_page_dirty(llbitmap, idx, offset);
> +}
> +
> +static struct page *llbitmap_read_page(struct llbitmap *llbitmap, int idx)
> +{
> +	struct mddev *mddev = llbitmap->mddev;
> +	struct page *page = NULL;
> +	struct md_rdev *rdev;
> +
> +	if (llbitmap->pctl && llbitmap->pctl[idx])
> +		page = llbitmap->pctl[idx]->page;
> +	if (page)
> +		return page;
> +
> +	page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> +	if (!page)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rdev_for_each(rdev, mddev) {
> +		sector_t sector;
> +
> +		if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
> +			continue;
> +
> +		sector = mddev->bitmap_info.offset +
> +			 (idx << PAGE_SECTORS_SHIFT);
> +
> +		if (sync_page_io(rdev, sector, PAGE_SIZE, page, REQ_OP_READ,
> +				 true))
> +			return page;
> +
> +		md_error(mddev, rdev);
> +	}
> +
> +	__free_page(page);
> +	return ERR_PTR(-EIO);
> +}
> +

Have you considered moving to folios here?

> +static void llbitmap_write_page(struct llbitmap *llbitmap, int idx)
> +{
> +	struct page *page = llbitmap->pctl[idx]->page;
> +	struct mddev *mddev = llbitmap->mddev;
> +	struct md_rdev *rdev;
> +	int bit;
> +
> +	for (bit = 0; bit < llbitmap->blocks_per_page; bit++) {
> +		struct llbitmap_page_ctl *pctl = llbitmap->pctl[idx];
> +
> +		if (!test_and_clear_bit(bit, pctl->dirty))
> +			continue;
> +
> +		rdev_for_each(rdev, mddev) {
> +			sector_t sector;
> +			sector_t bit_sector = llbitmap->io_size >> SECTOR_SHIFT;
> +
> +			if (rdev->raid_disk < 0 || test_bit(Faulty, &rdev->flags))
> +				continue;
> +
> +			sector = mddev->bitmap_info.offset + rdev->sb_start +
> +				 (idx << PAGE_SECTORS_SHIFT) +
> +				 bit * bit_sector;
> +			md_write_metadata(mddev, rdev, sector,
> +					  llbitmap->io_size, page,
> +					  bit * llbitmap->io_size);
> +		}
> +	}
> +}
> +

And here?

> +static void active_release(struct percpu_ref *ref)
> +{
> +	struct llbitmap_page_ctl *pctl =
> +		container_of(ref, struct llbitmap_page_ctl, active);
> +
> +	wake_up(&pctl->wait);
> +}
> +
> +static void llbitmap_free_pages(struct llbitmap *llbitmap)
> +{
> +	int i;
> +
> +	if (!llbitmap->pctl)
> +		return;
> +
> +	for (i = 0; i < llbitmap->nr_pages; i++) {
> +		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
> +
> +		if (!pctl || !pctl->page)
> +			break;
> +
> +		__free_page(pctl->page);
> +		percpu_ref_exit(&pctl->active);
> +	}
> +
> +	kfree(llbitmap->pctl[0]);
> +	kfree(llbitmap->pctl);
> +	llbitmap->pctl = NULL;
> +}
> +
> +static int llbitmap_cache_pages(struct llbitmap *llbitmap)
> +{
> +	struct llbitmap_page_ctl *pctl;
> +	unsigned int nr_pages = DIV_ROUND_UP(llbitmap->chunks +
> +					     BITMAP_DATA_OFFSET, PAGE_SIZE);
> +	unsigned int size = struct_size(pctl, dirty, BITS_TO_LONGS(
> +						llbitmap->blocks_per_page));
> +	int i;
> +
> +	llbitmap->pctl = kmalloc_array(nr_pages, sizeof(void *),
> +				       GFP_KERNEL | __GFP_ZERO);
> +	if (!llbitmap->pctl)
> +		return -ENOMEM;
> +
> +	size = round_up(size, cache_line_size());
> +	pctl = kmalloc_array(nr_pages, size, GFP_KERNEL | __GFP_ZERO);
> +	if (!pctl) {
> +		kfree(llbitmap->pctl);
> +		return -ENOMEM;
> +	}
> +
> +	llbitmap->nr_pages = nr_pages;
> +
> +	for (i = 0; i < nr_pages; i++, pctl = (void *)pctl + size) {
> +		struct page *page = llbitmap_read_page(llbitmap, i);
> +
> +		llbitmap->pctl[i] = pctl;
> +
> +		if (IS_ERR(page)) {
> +			llbitmap_free_pages(llbitmap);
> +			return PTR_ERR(page);
> +		}
> +
> +		if (percpu_ref_init(&pctl->active, active_release,
> +				    PERCPU_REF_ALLOW_REINIT, GFP_KERNEL)) {
> +			__free_page(page);
> +			llbitmap_free_pages(llbitmap);
> +			return -ENOMEM;
> +		}
> +
> +		pctl->page = page;
> +		pctl->state = page_address(page);
> +		init_waitqueue_head(&pctl->wait);
> +	}
> +
> +	return 0;
> +}
> +
> +static void llbitmap_init_state(struct llbitmap *llbitmap)
> +{
> +	enum llbitmap_state state = BitUnwritten;
> +	unsigned long i;
> +
> +	if (test_and_clear_bit(BITMAP_CLEAN, &llbitmap->flags))
> +		state = BitClean;
> +
> +	for (i = 0; i < llbitmap->chunks; i++)
> +		llbitmap_write(llbitmap, state, i);
> +}
> +
> +/* The return value is only used from resync, where @start == @end. */
> +static enum llbitmap_state llbitmap_state_machine(struct llbitmap *llbitmap,
> +						  unsigned long start,
> +						  unsigned long end,
> +						  enum llbitmap_action action)
> +{
> +	struct mddev *mddev = llbitmap->mddev;
> +	enum llbitmap_state state = BitNone;
> +	bool need_resync = false;
> +	bool need_recovery = false;
> +
> +	if (test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags))
> +		return BitNone;
> +
> +	if (action == BitmapActionInit) {
> +		llbitmap_init_state(llbitmap);
> +		return BitNone;
> +	}
> +
> +	while (start <= end) {
> +		enum llbitmap_state c = llbitmap_read(llbitmap, start);
> +
> +		if (c < 0 || c >= BitStateCount) {
> +			pr_err("%s: invalid bit %lu state %d action %d, forcing resync\n",
> +			       __func__, start, c, action);
> +			state = BitNeedSync;
> +			goto write_bitmap;
> +		}
> +
> +		if (c == BitNeedSync)
> +			need_resync = true;
> +
> +		state = state_machine[c][action];
> +		if (state == BitNone) {
> +			start++;
> +			continue;
> +		}
> +
> +write_bitmap:
> +		/* Delay raid456 initial recovery to first write. */
> +		if (c == BitUnwritten && state == BitDirty &&
> +		    action == BitmapActionStartwrite && raid_is_456(mddev)) {
> +			state = BitNeedSync;
> +			need_recovery = true;
> +		}
> +
> +		llbitmap_write(llbitmap, state, start);
> +
> +		if (state == BitNeedSync)
> +			need_resync = true;
> +		else if (state == BitDirty &&
> +			 !timer_pending(&llbitmap->pending_timer))
> +			mod_timer(&llbitmap->pending_timer,
> +				  jiffies + mddev->bitmap_info.daemon_sleep * HZ);
> +
> +		start++;
> +	}
> +
> +	if (need_recovery) {
> +		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> +		set_bit(MD_RECOVERY_LAZY_RECOVER, &mddev->recovery);
> +		md_wakeup_thread(mddev->thread);
> +	} else if (need_resync) {
> +		set_bit(MD_RECOVERY_NEEDED, &mddev->recovery);
> +		set_bit(MD_RECOVERY_SYNC, &mddev->recovery);
> +		md_wakeup_thread(mddev->thread);
> +	}
> +
> +	return state;
> +}
> +
> +static void llbitmap_raise_barrier(struct llbitmap *llbitmap, int page_idx)
> +{
> +	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
> +
> +retry:
> +	if (likely(percpu_ref_tryget_live(&pctl->active))) {
> +		WRITE_ONCE(pctl->expire, jiffies + BARRIER_IDLE * HZ);
> +		return;
> +	}
> +
> +	wait_event(pctl->wait, !percpu_ref_is_dying(&pctl->active));
> +	goto retry;
> +}
> +
> +static void llbitmap_release_barrier(struct llbitmap *llbitmap, int page_idx)
> +{
> +	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
> +
> +	percpu_ref_put(&pctl->active);
> +}
> +
> +static int llbitmap_suspend_timeout(struct llbitmap *llbitmap, int page_idx)
> +{
> +	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
> +
> +	percpu_ref_kill(&pctl->active);
> +
> +	if (!wait_event_timeout(pctl->wait, percpu_ref_is_zero(&pctl->active),
> +			llbitmap->mddev->bitmap_info.daemon_sleep * HZ))
> +		return -ETIMEDOUT;
> +
> +	return 0;
> +}
> +
> +static void llbitmap_resume(struct llbitmap *llbitmap, int page_idx)
> +{
> +	struct llbitmap_page_ctl *pctl = llbitmap->pctl[page_idx];
> +
> +	pctl->expire = LONG_MAX;
> +	percpu_ref_resurrect(&pctl->active);
> +	wake_up(&pctl->wait);
> +}
> +
> +static int llbitmap_check_support(struct mddev *mddev)
> +{
> +	if (test_bit(MD_HAS_JOURNAL, &mddev->flags)) {
> +		pr_notice("md/llbitmap: %s: array with journal cannot have bitmap\n",
> +			  mdname(mddev));
> +		return -EBUSY;
> +	}
> +
> +	if (mddev->bitmap_info.space == 0) {
> +		if (mddev->bitmap_info.default_space == 0) {
> +			pr_notice("md/llbitmap: %s: no space for bitmap\n",
> +				  mdname(mddev));
> +			return -ENOSPC;
> +		}
> +	}
> +
> +	if (!mddev->persistent) {
> +		pr_notice("md/llbitmap: %s: array must be persistent\n",
> +			  mdname(mddev));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (mddev->bitmap_info.file) {
> +		pr_notice("md/llbitmap: %s: doesn't support bitmap file\n",
> +			  mdname(mddev));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (mddev->bitmap_info.external) {
> +		pr_notice("md/llbitmap: %s: doesn't support external metadata\n",
> +			  mdname(mddev));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (mddev_is_dm(mddev)) {
> +		pr_notice("md/llbitmap: %s: doesn't support dm-raid\n",
> +			  mdname(mddev));
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int llbitmap_init(struct llbitmap *llbitmap)
> +{
> +	struct mddev *mddev = llbitmap->mddev;
> +	sector_t blocks = mddev->resync_max_sectors;
> +	unsigned long chunksize = MIN_CHUNK_SIZE;
> +	unsigned long chunks = DIV_ROUND_UP(blocks, chunksize);
> +	unsigned long space = mddev->bitmap_info.space << SECTOR_SHIFT;
> +	int ret;
> +
> +	while (chunks > space) {
> +		chunksize = chunksize << 1;
> +		chunks = DIV_ROUND_UP(blocks, chunksize);
> +	}
> +
> +	llbitmap->chunkshift = ffz(~chunksize);
> +	llbitmap->chunksize = chunksize;
> +	llbitmap->chunks = chunks;
> +	mddev->bitmap_info.daemon_sleep = DEFAULT_DAEMON_SLEEP;
> +
> +	ret = llbitmap_cache_pages(llbitmap);
> +	if (ret)
> +		return ret;
> +
> +	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1, BitmapActionInit);
> +	return 0;
> +}
> +
> +static int llbitmap_read_sb(struct llbitmap *llbitmap)
> +{
> +	struct mddev *mddev = llbitmap->mddev;
> +	unsigned long daemon_sleep;
> +	unsigned long chunksize;
> +	unsigned long events;
> +	struct page *sb_page;
> +	bitmap_super_t *sb;
> +	int ret = -EINVAL;
> +
> +	if (!mddev->bitmap_info.offset) {
> +		pr_err("md/llbitmap: %s: no super block found", mdname(mddev));
> +		return -EINVAL;
> +	}
> +
> +	sb_page = llbitmap_read_page(llbitmap, 0);
> +	if (IS_ERR(sb_page)) {
> +		pr_err("md/llbitmap: %s: read super block failed",
> +		       mdname(mddev));
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	sb = kmap_local_page(sb_page);
> +	if (sb->magic != cpu_to_le32(BITMAP_MAGIC)) {
> +		pr_err("md/llbitmap: %s: invalid super block magic number",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (sb->version != cpu_to_le32(BITMAP_MAJOR_LOCKLESS)) {
> +		pr_err("md/llbitmap: %s: invalid super block version",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (memcmp(sb->uuid, mddev->uuid, 16)) {
> +		pr_err("md/llbitmap: %s: bitmap superblock UUID mismatch\n",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (mddev->bitmap_info.space == 0) {
> +		int room = le32_to_cpu(sb->sectors_reserved);
> +
> +		if (room)
> +			mddev->bitmap_info.space = room;
> +		else
> +			mddev->bitmap_info.space = mddev->bitmap_info.default_space;
> +	}
> +	llbitmap->flags = le32_to_cpu(sb->state);
> +	if (test_and_clear_bit(BITMAP_FIRST_USE, &llbitmap->flags)) {
> +		ret = llbitmap_init(llbitmap);
> +		goto out_put_page;
> +	}
> +
> +	chunksize = le32_to_cpu(sb->chunksize);
> +	if (!is_power_of_2(chunksize)) {
> +		pr_err("md/llbitmap: %s: chunksize not a power of 2",
> +		       mdname(mddev));
> +		goto out_put_page;
> +	}
> +
> +	if (chunksize < DIV_ROUND_UP(mddev->resync_max_sectors,
> +				     mddev->bitmap_info.space << SECTOR_SHIFT)) {
> +		pr_err("md/llbitmap: %s: chunksize too small %lu < %llu / %lu",
> +		       mdname(mddev), chunksize, mddev->resync_max_sectors,
> +		       mddev->bitmap_info.space);
> +		goto out_put_page;
> +	}
> +
> +	daemon_sleep = le32_to_cpu(sb->daemon_sleep);
> +	if (daemon_sleep < 1 || daemon_sleep > MAX_SCHEDULE_TIMEOUT / HZ) {
> +		pr_err("md/llbitmap: %s: daemon sleep %lu period out of range",
> +		       mdname(mddev), daemon_sleep);
> +		goto out_put_page;
> +	}
> +
> +	events = le64_to_cpu(sb->events);
> +	if (events < mddev->events) {
> +		pr_warn("md/llbitmap :%s: bitmap file is out of date (%lu < %llu) -- forcing full recovery",
> +			mdname(mddev), events, mddev->events);
> +		set_bit(BITMAP_STALE, &llbitmap->flags);
> +	}
> +
> +	sb->sync_size = cpu_to_le64(mddev->resync_max_sectors);
> +	mddev->bitmap_info.chunksize = chunksize;
> +	mddev->bitmap_info.daemon_sleep = daemon_sleep;
> +
> +	llbitmap->chunksize = chunksize;
> +	llbitmap->chunks = DIV_ROUND_UP(mddev->resync_max_sectors, chunksize);
> +	llbitmap->chunkshift = ffz(~chunksize);
> +	ret = llbitmap_cache_pages(llbitmap);
> +
> +out_put_page:
> +	__free_page(sb_page);
> +out:
> +	kunmap_local(sb);
> +	return ret;
> +}
> +

Again, using folios here?

> +static void llbitmap_pending_timer_fn(struct timer_list *t)
> +{
> +	struct llbitmap *llbitmap = from_timer(llbitmap, t, pending_timer);
> +
> +	if (work_busy(&llbitmap->daemon_work)) {
> +		pr_warn("md/llbitmap: %s daemon_work not finished in %lu seconds\n",
> +			mdname(llbitmap->mddev),
> +			llbitmap->mddev->bitmap_info.daemon_sleep);
> +		set_bit(BITMAP_DAEMON_BUSY, &llbitmap->flags);
> +		return;
> +	}
> +
> +	queue_work(md_llbitmap_io_wq, &llbitmap->daemon_work);
> +}
> +
> +static void md_llbitmap_daemon_fn(struct work_struct *work)
> +{
> +	struct llbitmap *llbitmap =
> +		container_of(work, struct llbitmap, daemon_work);
> +	unsigned long start;
> +	unsigned long end;
> +	bool restart;
> +	int idx;
> +
> +	if (llbitmap->mddev->degraded)
> +		return;
> +
> +retry:
> +	start = 0;
> +	end = min(llbitmap->chunks, PAGE_SIZE - BITMAP_DATA_OFFSET) - 1;
> +	restart = false;
> +
> +	for (idx = 0; idx < llbitmap->nr_pages; idx++) {
> +		struct llbitmap_page_ctl *pctl = llbitmap->pctl[idx];
> +
> +		if (idx > 0) {
> +			start = end + 1;
> +			end = min(end + PAGE_SIZE, llbitmap->chunks - 1);
> +		}
> +
> +		if (!test_bit(LLPageFlush, &pctl->flags) &&
> +		    time_before(jiffies, pctl->expire)) {
> +			restart = true;
> +			continue;
> +		}
> +
> +		if (llbitmap_suspend_timeout(llbitmap, idx) < 0) {
> +			pr_warn("md/llbitmap: %s: %s waiting for page %d timeout\n",
> +				mdname(llbitmap->mddev), __func__, idx);
> +			continue;
> +		}
> +
> +		llbitmap_state_machine(llbitmap, start, end, BitmapActionDaemon);
> +		llbitmap_resume(llbitmap, idx);
> +	}
> +
> +	/*
> +	 * If the daemon took a long time to finish, retry to prevent missing
> +	 * clearing dirty bits.
> +	 */
> +	if (test_and_clear_bit(BITMAP_DAEMON_BUSY, &llbitmap->flags))
> +		goto retry;
> +
> +	/* If some page is dirty but not expired, setup timer again */
> +	if (restart)
> +		mod_timer(&llbitmap->pending_timer,
> +			  jiffies + llbitmap->mddev->bitmap_info.daemon_sleep * HZ);
> +}
> +
> +static int llbitmap_create(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap;
> +	int ret;
> +
> +	ret = llbitmap_check_support(mddev);
> +	if (ret)
> +		return ret;
> +
> +	llbitmap = kzalloc(sizeof(*llbitmap), GFP_KERNEL);
> +	if (!llbitmap)
> +		return -ENOMEM;
> +
> +	llbitmap->mddev = mddev;
> +	llbitmap->io_size = bdev_logical_block_size(mddev->gendisk->part0);
> +	llbitmap->blocks_per_page = PAGE_SIZE / llbitmap->io_size;
> +
> +	timer_setup(&llbitmap->pending_timer, llbitmap_pending_timer_fn, 0);
> +	INIT_WORK(&llbitmap->daemon_work, md_llbitmap_daemon_fn);
> +	atomic_set(&llbitmap->behind_writes, 0);
> +	init_waitqueue_head(&llbitmap->behind_wait);
> +
> +	mutex_lock(&mddev->bitmap_info.mutex);
> +	mddev->bitmap = llbitmap;
> +	ret = llbitmap_read_sb(llbitmap);
> +	mutex_unlock(&mddev->bitmap_info.mutex);
> +	if (ret)
> +		goto err_out;
> +
> +	return 0;
> +
> +err_out:
> +	kfree(llbitmap);
> +	return ret;
> +}
> +
> +static int llbitmap_resize(struct mddev *mddev, sector_t blocks, int chunksize)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long chunks;
> +
> +	if (chunksize == 0)
> +		chunksize = llbitmap->chunksize;
> +
> +	/* If there is enough space, leave the chunksize unchanged. */
> +	chunks = DIV_ROUND_UP(blocks, chunksize);
> +	while (chunks > mddev->bitmap_info.space << SECTOR_SHIFT) {
> +		chunksize = chunksize << 1;
> +		chunks = DIV_ROUND_UP(blocks, chunksize);
> +	}
> +
> +	llbitmap->chunkshift = ffz(~chunksize);
> +	llbitmap->chunksize = chunksize;
> +	llbitmap->chunks = chunks;
> +
> +	return 0;
> +}
> +

Hmm. I do get confused with the chunksize here.
Is this the granularity of the bits in the bitmap
(ie how many data bytes are covered by one bit)?
Or is it the chunksize of the bitmap itself?

In either case, if it's a 'chunksize' in the sense
of the block layer (namely a boundary which I/O
must not cross), shouldn't you set the request
queue limits accordingly?

> +static int llbitmap_load(struct mddev *mddev)
> +{
> +	enum llbitmap_action action = BitmapActionReload;
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	if (test_and_clear_bit(BITMAP_STALE, &llbitmap->flags))
> +		action = BitmapActionStale;
> +
> +	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1, action);
> +	return 0;
> +}
> +
> +static void llbitmap_destroy(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	if (!llbitmap)
> +		return;
> +
> +	mutex_lock(&mddev->bitmap_info.mutex);
> +
> +	timer_delete_sync(&llbitmap->pending_timer);
> +	flush_workqueue(md_llbitmap_io_wq);
> +	flush_workqueue(md_llbitmap_unplug_wq);
> +
> +	mddev->bitmap = NULL;
> +	llbitmap_free_pages(llbitmap);
> +	kfree(llbitmap);
> +	mutex_unlock(&mddev->bitmap_info.mutex);
> +}
> +
> +static void llbitmap_start_write(struct mddev *mddev, sector_t offset,
> +				 unsigned long sectors)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long start = offset >> llbitmap->chunkshift;
> +	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
> +	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +
> +	llbitmap_state_machine(llbitmap, start, end, BitmapActionStartwrite);
> +
> +
> +	while (page_start <= page_end) {
> +		llbitmap_raise_barrier(llbitmap, page_start);
> +		page_start++;
> +	}
> +}
> +
> +static void llbitmap_end_write(struct mddev *mddev, sector_t offset,
> +			       unsigned long sectors)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long start = offset >> llbitmap->chunkshift;
> +	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
> +	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +
> +	while (page_start <= page_end) {
> +		llbitmap_release_barrier(llbitmap, page_start);
> +		page_start++;
> +	}
> +}
> +
> +static void llbitmap_start_discard(struct mddev *mddev, sector_t offset,
> +				   unsigned long sectors)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long start = DIV_ROUND_UP(offset, llbitmap->chunksize);
> +	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
> +	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +
> +	llbitmap_state_machine(llbitmap, start, end, BitmapActionDiscard);
> +
> +	while (page_start <= page_end) {
> +		llbitmap_raise_barrier(llbitmap, page_start);
> +		page_start++;
> +	}
> +}
> +
> +static void llbitmap_end_discard(struct mddev *mddev, sector_t offset,
> +				 unsigned long sectors)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long start = DIV_ROUND_UP(offset, llbitmap->chunksize);
> +	unsigned long end = (offset + sectors - 1) >> llbitmap->chunkshift;
> +	int page_start = (start + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +	int page_end = (end + BITMAP_DATA_OFFSET) >> PAGE_SHIFT;
> +
> +	while (page_start <= page_end) {
> +		llbitmap_release_barrier(llbitmap, page_start);
> +		page_start++;
> +	}
> +}
> +
> +static void llbitmap_unplug_fn(struct work_struct *work)
> +{
> +	struct llbitmap_unplug_work *unplug_work =
> +		container_of(work, struct llbitmap_unplug_work, work);
> +	struct llbitmap *llbitmap = unplug_work->llbitmap;
> +	struct blk_plug plug;
> +	int i;
> +
> +	blk_start_plug(&plug);
> +
> +	for (i = 0; i < llbitmap->nr_pages; i++) {
> +		if (!test_bit(LLPageDirty, &llbitmap->pctl[i]->flags) ||
> +		    !test_and_clear_bit(LLPageDirty, &llbitmap->pctl[i]->flags))

Confused. Is this some kind of micro-optimisation?
Why not simply 'test_and_clear_bit()'?

> +			continue;
> +
> +		llbitmap_write_page(llbitmap, i);
> +	}
> +
> +	blk_finish_plug(&plug);
> +	md_super_wait(llbitmap->mddev);
> +	complete(unplug_work->done);
> +}
> +
> +static bool llbitmap_dirty(struct llbitmap *llbitmap)
> +{
> +	int i;
> +
> +	for (i = 0; i < llbitmap->nr_pages; i++)
> +		if (test_bit(LLPageDirty, &llbitmap->pctl[i]->flags))
> +			return true;
> +
> +	return false;
> +}
> +
> +static void llbitmap_unplug(struct mddev *mddev, bool sync)
> +{
> +	DECLARE_COMPLETION_ONSTACK(done);
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	struct llbitmap_unplug_work unplug_work = {
> +		.llbitmap = llbitmap,
> +		.done = &done,
> +	};
> +
> +	if (!llbitmap_dirty(llbitmap))
> +		return;
> +
> +	/*
> +	 * Issue new bitmap IO under submit_bio() context will deadlock:
> +	 *  - the bio will wait for bitmap bio to be done, before it can be
> +	 *  issued;
> +	 *  - bitmap bio will be added to current->bio_list and wait for this
> +	 *  bio to be issued;
> +	 */
> +	INIT_WORK_ONSTACK(&unplug_work.work, llbitmap_unplug_fn);
> +	queue_work(md_llbitmap_unplug_wq, &unplug_work.work);
> +	wait_for_completion(&done);
> +	destroy_work_on_stack(&unplug_work.work);
> +}
> +
> +/*
> + * Force to write all bitmap pages to disk, called when stopping the array, or
> + * every daemon_sleep seconds when sync_thread is running.
> + */
> +static void __llbitmap_flush(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	struct blk_plug plug;
> +	int i;
> +
> +	blk_start_plug(&plug);
> +	for (i = 0; i < llbitmap->nr_pages; i++) {
> +		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
> +
> +		/* mark all bits as dirty */
> +		set_bit(LLPageDirty, &pctl->flags);
> +		bitmap_fill(pctl->dirty, llbitmap->blocks_per_page);
> +		llbitmap_write_page(llbitmap, i);
> +	}
> +	blk_finish_plug(&plug);
> +	md_super_wait(llbitmap->mddev);
> +}
> +
> +static void llbitmap_flush(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	int i;
> +
> +	for (i = 0; i < llbitmap->nr_pages; i++)
> +		set_bit(LLPageFlush, &llbitmap->pctl[i]->flags);
> +
> +	timer_delete_sync(&llbitmap->pending_timer);
> +	queue_work(md_llbitmap_io_wq, &llbitmap->daemon_work);
> +	flush_work(&llbitmap->daemon_work);
> +
> +	__llbitmap_flush(mddev);
> +}
> +
> +/* This is used for raid5 lazy initial recovery */
> +static bool llbitmap_blocks_synced(struct mddev *mddev, sector_t offset)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long p = offset >> llbitmap->chunkshift;
> +	enum llbitmap_state c = llbitmap_read(llbitmap, p);
> +
> +	return c == BitClean || c == BitDirty;
> +}
> +
> +static sector_t llbitmap_skip_sync_blocks(struct mddev *mddev, sector_t offset)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long p = offset >> llbitmap->chunkshift;
> +	int blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
> +	enum llbitmap_state c = llbitmap_read(llbitmap, p);
> +
> +	/* always skip unwritten blocks */
> +	if (c == BitUnwritten)
> +		return blocks;
> +
> +	/* For resync also skip clean/dirty blocks */
> +	if ((c == BitClean || c == BitDirty) &&
> +	    test_bit(MD_RECOVERY_SYNC, &mddev->recovery) &&
> +	    !test_bit(MD_RECOVERY_REQUESTED, &mddev->recovery))
> +		return blocks;
> +
> +	return 0;
> +}
> +
> +static bool llbitmap_start_sync(struct mddev *mddev, sector_t offset,
> +				sector_t *blocks, bool degraded)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long p = offset >> llbitmap->chunkshift;
> +
> +	/*
> +	 * Handle one bit at a time, this is much simpler. And it doesn't matter
> +	 * if md_do_sync() loop more times.
> +	 */
> +	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
> +	return llbitmap_state_machine(llbitmap, p, p,
> +				      BitmapActionStartsync) == BitSyncing;
> +}
> +
> +/* Something is wrong, sync_thread stop at @offset */
> +static void llbitmap_end_sync(struct mddev *mddev, sector_t offset,
> +			      sector_t *blocks)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	unsigned long p = offset >> llbitmap->chunkshift;
> +
> +	*blocks = llbitmap->chunksize - (offset & (llbitmap->chunksize - 1));
> +	llbitmap_state_machine(llbitmap, p, llbitmap->chunks - 1,
> +			       BitmapActionAbortsync);
> +}
> +
> +/* A full sync_thread is finished */
> +static void llbitmap_close_sync(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +	int i;
> +
> +	for (i = 0; i < llbitmap->nr_pages; i++) {
> +		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
> +
> +		/* let daemon_fn clear dirty bits immediately */
> +		WRITE_ONCE(pctl->expire, jiffies);
> +	}
> +
> +	llbitmap_state_machine(llbitmap, 0, llbitmap->chunks - 1,
> +			       BitmapActionEndsync);
> +}
> +
> +/*
> + * sync_thread have reached @sector, update metadata every daemon_sleep seconds,
> + * just in case sync_thread have to restart after power failure.
> + */
> +static void llbitmap_cond_end_sync(struct mddev *mddev, sector_t sector,
> +				   bool force)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	if (sector == 0) {
> +		llbitmap->last_end_sync = jiffies;
> +		return;
> +	}
> +
> +	if (time_before(jiffies, llbitmap->last_end_sync +
> +				 HZ * mddev->bitmap_info.daemon_sleep))
> +		return;
> +
> +	wait_event(mddev->recovery_wait, !atomic_read(&mddev->recovery_active));
> +
> +	mddev->curr_resync_completed = sector;
> +	set_bit(MD_SB_CHANGE_CLEAN, &mddev->sb_flags);
> +	llbitmap_state_machine(llbitmap, 0, sector >> llbitmap->chunkshift,
> +			       BitmapActionEndsync);
> +	__llbitmap_flush(mddev);
> +
> +	llbitmap->last_end_sync = jiffies;
> +	sysfs_notify_dirent_safe(mddev->sysfs_completed);
> +}
> +
> +static bool llbitmap_enabled(void *data, bool flush)
> +{
> +	struct llbitmap *llbitmap = data;
> +
> +	return llbitmap && !test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags);
> +}
> +
> +static void llbitmap_dirty_bits(struct mddev *mddev, unsigned long s,
> +				unsigned long e)
> +{
> +	llbitmap_state_machine(mddev->bitmap, s, e, BitmapActionStartwrite);
> +}
> +
> +static void llbitmap_write_sb(struct llbitmap *llbitmap)
> +{
> +	int nr_bits = DIV_ROUND_UP(BITMAP_DATA_OFFSET, llbitmap->io_size);
> +
> +	bitmap_fill(llbitmap->pctl[0]->dirty, nr_bits);
> +	llbitmap_write_page(llbitmap, 0);
> +	md_super_wait(llbitmap->mddev);
> +}
> +
> +static void llbitmap_update_sb(void *data)
> +{
> +	struct llbitmap *llbitmap = data;
> +	struct mddev *mddev = llbitmap->mddev;
> +	struct page *sb_page;
> +	bitmap_super_t *sb;
> +
> +	if (test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags))
> +		return;
> +
> +	sb_page = llbitmap_read_page(llbitmap, 0);
> +	if (IS_ERR(sb_page)) {
> +		pr_err("%s: %s: read super block failed", __func__,
> +		       mdname(mddev));
> +		set_bit(BITMAP_WRITE_ERROR, &llbitmap->flags);
> +		return;
> +	}
> +
> +	if (mddev->events < llbitmap->events_cleared)
> +		llbitmap->events_cleared = mddev->events;
> +
> +	sb = kmap_local_page(sb_page);
> +	sb->events = cpu_to_le64(mddev->events);
> +	sb->state = cpu_to_le32(llbitmap->flags);
> +	sb->chunksize = cpu_to_le32(llbitmap->chunksize);
> +	sb->sync_size = cpu_to_le64(mddev->resync_max_sectors);
> +	sb->events_cleared = cpu_to_le64(llbitmap->events_cleared);
> +	sb->sectors_reserved = cpu_to_le32(mddev->bitmap_info.space);
> +	sb->daemon_sleep = cpu_to_le32(mddev->bitmap_info.daemon_sleep);
> +
> +	kunmap_local(sb);
> +	llbitmap_write_sb(llbitmap);
> +}
> +
> +static int llbitmap_get_stats(void *data, struct md_bitmap_stats *stats)
> +{
> +	struct llbitmap *llbitmap = data;
> +
> +	memset(stats, 0, sizeof(*stats));
> +
> +	stats->missing_pages = 0;
> +	stats->pages = llbitmap->nr_pages;
> +	stats->file_pages = llbitmap->nr_pages;
> +
> +	stats->behind_writes = atomic_read(&llbitmap->behind_writes);
> +	stats->behind_wait = wq_has_sleeper(&llbitmap->behind_wait);
> +	stats->events_cleared = llbitmap->events_cleared;
> +
> +	return 0;
> +}
> +
> +/* just flag all pages as needing to be written */
> +static void llbitmap_write_all(struct mddev *mddev)
> +{
> +	int i;
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	for (i = 0; i < llbitmap->nr_pages; i++) {
> +		struct llbitmap_page_ctl *pctl = llbitmap->pctl[i];
> +
> +		set_bit(LLPageDirty, &pctl->flags);
> +		bitmap_fill(pctl->dirty, llbitmap->blocks_per_page);
> +	}
> +}
> +
> +static void llbitmap_start_behind_write(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	atomic_inc(&llbitmap->behind_writes);
> +}
> +
> +static void llbitmap_end_behind_write(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	if (atomic_dec_and_test(&llbitmap->behind_writes))
> +		wake_up(&llbitmap->behind_wait);
> +}
> +
> +static void llbitmap_wait_behind_writes(struct mddev *mddev)
> +{
> +	struct llbitmap *llbitmap = mddev->bitmap;
> +
> +	if (!llbitmap)
> +		return;
> +
> +	wait_event(llbitmap->behind_wait,
> +		   atomic_read(&llbitmap->behind_writes) == 0);
> +
> +}
> +
> +static ssize_t bits_show(struct mddev *mddev, char *page)
> +{
> +	struct llbitmap *llbitmap;
> +	int bits[BitStateCount] = {0};
> +	loff_t start = 0;
> +
> +	mutex_lock(&mddev->bitmap_info.mutex);
> +	llbitmap = mddev->bitmap;
> +	if (!llbitmap || !llbitmap->pctl) {
> +		mutex_unlock(&mddev->bitmap_info.mutex);
> +		return sprintf(page, "no bitmap\n");
> +	}
> +
> +	if (test_bit(BITMAP_WRITE_ERROR, &llbitmap->flags)) {
> +		mutex_unlock(&mddev->bitmap_info.mutex);
> +		return sprintf(page, "bitmap io error\n");
> +	}
> +
> +	while (start < llbitmap->chunks) {
> +		enum llbitmap_state c = llbitmap_read(llbitmap, start);
> +
> +		if (c < 0 || c >= BitStateCount)
> +			pr_err("%s: invalid bit %llu state %d\n",
> +			       __func__, start, c);
> +		else
> +			bits[c]++;
> +		start++;
> +	}
> +
> +	mutex_unlock(&mddev->bitmap_info.mutex);
> +	return sprintf(page, "unwritten %d\nclean %d\ndirty %d\nneed sync %d\nsyncing %d\n",
> +		       bits[BitUnwritten], bits[BitClean], bits[BitDirty],
> +		       bits[BitNeedSync], bits[BitSyncing]);
> +}
> +
> +static struct md_sysfs_entry llbitmap_bits =
> +__ATTR_RO(bits);
> +
> +static ssize_t metadata_show(struct mddev *mddev, char *page)
> +{
> +	struct llbitmap *llbitmap;
> +	ssize_t ret;
> +
> +	mutex_lock(&mddev->bitmap_info.mutex);
> +	llbitmap = mddev->bitmap;
> +	if (!llbitmap) {
> +		mutex_unlock(&mddev->bitmap_info.mutex);
> +		return sprintf(page, "no bitmap\n");
> +	}
> +
> +	ret =  sprintf(page, "chunksize %lu\nchunkshift %lu\nchunks %lu\noffset %llu\ndaemon_sleep %lu\n",
> +		       llbitmap->chunksize, llbitmap->chunkshift,
> +		       llbitmap->chunks, mddev->bitmap_info.offset,
> +		       llbitmap->mddev->bitmap_info.daemon_sleep);
> +	mutex_unlock(&mddev->bitmap_info.mutex);
> +
> +	return ret;
> +}
> +
> +static struct md_sysfs_entry llbitmap_metadata =
> +__ATTR_RO(metadata);
> +
> +static ssize_t
> +daemon_sleep_show(struct mddev *mddev, char *page)
> +{
> +	return sprintf(page, "%lu\n", mddev->bitmap_info.daemon_sleep);
> +}
> +
> +static ssize_t
> +daemon_sleep_store(struct mddev *mddev, const char *buf, size_t len)
> +{
> +	unsigned long timeout;
> +	int rv = kstrtoul(buf, 10, &timeout);
> +
> +	if (rv)
> +		return rv;
> +
> +	mddev->bitmap_info.daemon_sleep = timeout;
> +	return len;
> +}
> +
> +static struct md_sysfs_entry llbitmap_daemon_sleep =
> +__ATTR_RW(daemon_sleep);
> +
> +static struct attribute *md_llbitmap_attrs[] = {
> +	&llbitmap_bits.attr,
> +	&llbitmap_metadata.attr,
> +	&llbitmap_daemon_sleep.attr,
> +	NULL
> +};
> +
> +static struct attribute_group md_llbitmap_group = {
> +	.name = "llbitmap",
> +	.attrs = md_llbitmap_attrs,
> +};
> +
> +static struct bitmap_operations llbitmap_ops = {
> +	.head = {
> +		.type	= MD_BITMAP,
> +		.id	= ID_LLBITMAP,
> +		.name	= "llbitmap",
> +	},
> +
> +	.enabled		= llbitmap_enabled,
> +	.create			= llbitmap_create,
> +	.resize			= llbitmap_resize,
> +	.load			= llbitmap_load,
> +	.destroy		= llbitmap_destroy,
> +
> +	.start_write		= llbitmap_start_write,
> +	.end_write		= llbitmap_end_write,
> +	.start_discard		= llbitmap_start_discard,
> +	.end_discard		= llbitmap_end_discard,
> +	.unplug			= llbitmap_unplug,
> +	.flush			= llbitmap_flush,
> +
> +	.start_behind_write	= llbitmap_start_behind_write,
> +	.end_behind_write	= llbitmap_end_behind_write,
> +	.wait_behind_writes	= llbitmap_wait_behind_writes,
> +
> +	.blocks_synced		= llbitmap_blocks_synced,
> +	.skip_sync_blocks	= llbitmap_skip_sync_blocks,
> +	.start_sync		= llbitmap_start_sync,
> +	.end_sync		= llbitmap_end_sync,
> +	.close_sync		= llbitmap_close_sync,
> +	.cond_end_sync		= llbitmap_cond_end_sync,
> +
> +	.update_sb		= llbitmap_update_sb,
> +	.get_stats		= llbitmap_get_stats,
> +	.dirty_bits		= llbitmap_dirty_bits,
> +	.write_all		= llbitmap_write_all,
> +
> +	.group			= &md_llbitmap_group,
> +};
> +
> +int md_llbitmap_init(void)
> +{
> +	md_llbitmap_io_wq = alloc_workqueue("md_llbitmap_io",
> +					 WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> +	if (!md_llbitmap_io_wq)
> +		return -ENOMEM;
> +
> +	md_llbitmap_unplug_wq = alloc_workqueue("md_llbitmap_unplug",
> +					 WQ_MEM_RECLAIM | WQ_UNBOUND, 0);
> +	if (!md_llbitmap_unplug_wq) {
> +		destroy_workqueue(md_llbitmap_io_wq);
> +		md_llbitmap_io_wq = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	return register_md_submodule(&llbitmap_ops.head);
> +}
> +
> +void md_llbitmap_exit(void)
> +{
> +	destroy_workqueue(md_llbitmap_io_wq);
> +	md_llbitmap_io_wq = NULL;
> +	destroy_workqueue(md_llbitmap_unplug_wq);
> +	md_llbitmap_unplug_wq = NULL;
> +	unregister_md_submodule(&llbitmap_ops.head);
> +}
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 1ab6bba63890..fa08ee539711 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -10215,6 +10215,10 @@ static int __init md_init(void)
>   	if (ret)
>   		return ret;
>   
> +	ret = md_llbitmap_init();
> +	if (ret)
> +		goto err_bitmap;
> +
>   	ret = -ENOMEM;
>   	md_wq = alloc_workqueue("md", WQ_MEM_RECLAIM, 0);
>   	if (!md_wq)
> @@ -10246,6 +10250,8 @@ static int __init md_init(void)
>   err_misc_wq:
>   	destroy_workqueue(md_wq);
>   err_wq:
> +	md_llbitmap_exit();
> +err_bitmap:
>   	md_bitmap_exit();
>   	return ret;
>   }
> diff --git a/drivers/md/md.h b/drivers/md/md.h
> index d7ba4e798465..42c6d709586b 100644
> --- a/drivers/md/md.h
> +++ b/drivers/md/md.h
> @@ -26,7 +26,7 @@
>   enum md_submodule_type {
>   	MD_PERSONALITY = 0,
>   	MD_CLUSTER,
> -	MD_BITMAP, /* TODO */
> +	MD_BITMAP,
>   };
>   
>   enum md_submodule_id {
> @@ -39,7 +39,7 @@ enum md_submodule_id {
>   	ID_RAID10	= 10,
>   	ID_CLUSTER,
>   	ID_BITMAP,
> -	ID_LLBITMAP,	/* TODO */
> +	ID_LLBITMAP,
>   	ID_BITMAP_NONE,
>   };
>   

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

