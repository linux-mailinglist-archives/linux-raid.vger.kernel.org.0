Return-Path: <linux-raid+bounces-1563-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E418CD90C
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2024 19:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D536AB22EA6
	for <lists+linux-raid@lfdr.de>; Thu, 23 May 2024 17:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7933762DC;
	Thu, 23 May 2024 17:14:13 +0000 (UTC)
X-Original-To: linux-raid@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C3A54FB5
	for <linux-raid@vger.kernel.org>; Thu, 23 May 2024 17:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484453; cv=none; b=XgszkpNrT0DBQPItfa7F7RJYVJf86RbxKd2jaCaMP08nq6cWNTIacAIROMrnAfIGwpfNdlDhVb362ULQY/CC5pVeI3IGo09CKFr+57b5op+hLOO55DisFWKD7bxUiPxNd5zn89xZ+MkfEufFlX4sQSe1VnPIRdJvxpe3R0nrLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484453; c=relaxed/simple;
	bh=+6Ej6+V7JSASFl6xwXwaI0Nd374hyR6rEnfM0hJ0CvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/tDtKZkzhdXpWlW6eFRtwRZ2NCwO6ZHBsmN1mk3ZnBapomQgWbaMXXx1/vwKHytZPlD02P6YpoMnKL7vuQHmIHOQRM1Xi9iur2Vo9GcoCYUT/aUKF0OezqVJ4gxHac/8pQNuvd1CXnfTrtSuVn6RLuzozqUadQbpTmrUg4oTko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ab9ce74bddso165326d6.0
        for <linux-raid@vger.kernel.org>; Thu, 23 May 2024 10:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716484451; x=1717089251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzmpCB59GSrDk5hFUMou10m427x6o85nt9s0M9X2cEI=;
        b=akTY3jkMsLJ6/Vj9J+aNlqtDKDz2XT+9PxqIVJp22FwNqrCohbNSD2cSoQzgvdsCzv
         Hx1p6sPGh+3uluG4ZTDFUJb/ClZeBmvuHIYvbRXMjB+GV3rdf8/NqFEEcdAiSNaNAcw3
         oNSo1pioQynvJ3dLDXwdoSUyInHg/1Pm6G/NTQof8bjpuqX1QnoCfnU6PxCYI2EM9H+5
         cMIxioXVx9EArLWE5cWkNUxIDc9YRgQxTdfeZitxqWB93v2UWUpbfd1zjnoEPhsp+Hdw
         lfb1eHsw9nLGnG89CpyCTALqpXMdgu+H3xpoDIXVgALh1KZzWV7lFfL3w6M4ya4N9bkc
         NcPA==
X-Forwarded-Encrypted: i=1; AJvYcCVlLwc3ThjDvs732yzo3N+3hs6Sxn7lze4x3VJAFEnPWtAF0/olbfM2pAHAq73bmTAKwqSkGFvCfMagYfci4NZwgGkegZhBh0jmKQ==
X-Gm-Message-State: AOJu0YxND00L8YBkTvULZNVm6LEUxHSSj5hZYpa40mhUVZH2VvlcKsD9
	fTXWnLfiXu2IDit2uHxiD4rXzILDdvFGthvSj35UqnMOz+y2q1I8lcp/iJJBd9A=
X-Google-Smtp-Source: AGHT+IE0ppZklj8z7bcsUa2Mv8eNJe9hLf2Ih8JeHK+KyBpe/0oUWLFLwBqabSTngtcVzwCEh120Vw==
X-Received: by 2002:a05:6214:5786:b0:6aa:9998:3170 with SMTP id 6a1803df08f44-6ab7f3560a7mr55555256d6.22.1716484450875;
        Thu, 23 May 2024 10:14:10 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a1624fb686sm142714746d6.124.2024.05.23.10.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:14:10 -0700 (PDT)
Date: Thu, 23 May 2024 13:14:09 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>, axboe@kernel.dk,
	dm-devel@lists.linux.dev, linux-block@vger.kernel.org,
	Marco Patalano <mpatalan@redhat.com>,
	Ewan Milne <emilne@redhat.com>, linux-raid@vger.kernel.org
Subject: Re: [PATCH for-6.10-rc1] block: fix blk_validate_limits() to
 properly handle stacked devices
Message-ID: <Zk95YRs-A-pxijMp@kernel.org>
References: <20240522025117.75568-1-snitzer@kernel.org>
 <20240522142458.GB7502@lst.de>
 <Zk4h-6f2M0XmraJV@kernel.org>
 <Zk6haNVa5JXxlOf1@fedora>
 <Zk9i7V2GRoHxBPRu@kernel.org>
 <20240523154435.GA1783@lst.de>
 <Zk9lYpthswuegMhn@kernel.org>
 <20240523155217.GA2346@lst.de>
 <Zk9xAJur96MVX0cy@kernel.org>
 <20240523170529.GB5736@lst.de>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523170529.GB5736@lst.de>

On Thu, May 23, 2024 at 07:05:29PM +0200, Christoph Hellwig wrote:
> On Thu, May 23, 2024 at 12:38:24PM -0400, Mike Snitzer wrote:
> > Happy to see mptest get folded into blktests (its just bash code) --
> > but it doesn't reproduce for you so not a reliable safeguard.
> 
> It is a lot better than not running it.  And I'll look into why
> it doesn't reproduce.  Right now the only thing I can think of is
> different kernel configs, maybe related to schedulers.  Can you send
> me your .config?

Will do off-list.

> Is adding mptests something you want to do, or you'd prefer outhers
> to take care of?

I won't have time in the near or mid-term.  So if someone else would
like to convert mptests over to blktests that'd be wonderful.

Fanning out to test the various supported test permutations would be
cool (meaning, test with both MULTIPATH_BACKEND_MODULE=scsidebug and
MULTIPATH_BACKEND_MODULE=tcmloop ... but tcmloop is brittle due to
sysfs changes vs targetcli's sysfs expectations -- but that's a
targetcli issue that might have been fixed, assuming that code is
supported still?  Not revisited in a few months)

