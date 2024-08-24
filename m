Return-Path: <linux-raid+bounces-2562-lists+linux-raid=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA9FE95DBD6
	for <lists+linux-raid@lfdr.de>; Sat, 24 Aug 2024 07:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B0F1F21A4A
	for <lists+linux-raid@lfdr.de>; Sat, 24 Aug 2024 05:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3047B154435;
	Sat, 24 Aug 2024 05:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RLdUEpqv"
X-Original-To: linux-raid@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7D5152196;
	Sat, 24 Aug 2024 05:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476689; cv=none; b=D7oGd1xK3Q55wHol5XMwxVc/8hdFAitgGWvSfAyCLzUn9RhS9BIDKagyM65IE69H7xO7J1pnTPqO6/deGwcc6p6QDQvyz0lMiTDafbKFF2RWDauU/W6b7+xQZfqgJWx1tJICuAk5a0UU7cOTaMBplSLHeHXLGC2H4NgT2oyJDCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476689; c=relaxed/simple;
	bh=tbL42V7xA89gdaoQidKlBjowYiUCMvR8ALjXWE5YhkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTdLoHMNqnNXdWqPPza6UCOruO0p8FVYGklitTT2V/AoYjfziDtq4wzKSR2CQGvPsDwZD7Cwwchimg+tMLtaaIkKWwbQdnoNUGpd1IUn2E/iTZamxFip9BuKv9luRnCvDPmNj6teL29VEu2FwzsUN7cLCRXwX5+0Mxot8y8+58Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RLdUEpqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8ABC32781;
	Sat, 24 Aug 2024 05:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476689;
	bh=tbL42V7xA89gdaoQidKlBjowYiUCMvR8ALjXWE5YhkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RLdUEpqv7Kr/6oelFfLOU/fDluRcUft0DZ3+6Y8zyEjCzjlQ8ECT6WwIEI6k2yTv6
	 QvkQCs+xvaPaDh1q17t3t/gcQ04Z1C/N9H1i5UgzZH170PkLfPEnbzBBp7vu6NgE26
	 UJtUW3l8uxLpyBEYLQoDnZr9zWwhDXi7ZwTJbGXE=
Date: Sat, 24 Aug 2024 10:26:09 +0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: teigland@redhat.com, gfs2@lists.linux.dev, song@kernel.org,
	yukuai3@huawei.com, agruenba@redhat.com, mark@fasheh.com,
	jlbec@evilplan.org, joseph.qi@linux.alibaba.com, rafael@kernel.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-raid@vger.kernel.org, ocfs2-devel@lists.linux.dev,
	lucien.xin@gmail.com
Subject: Re: [RFC dlm/next 08/12] kobject: add kset_type_create_and_add()
 helper
Message-ID: <2024082459-neatly-screen-9d29@gregkh>
References: <20240814143414.1877505-1-aahringo@redhat.com>
 <20240814143414.1877505-9-aahringo@redhat.com>
Precedence: bulk
X-Mailing-List: linux-raid@vger.kernel.org
List-Id: <linux-raid.vger.kernel.org>
List-Subscribe: <mailto:linux-raid+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-raid+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814143414.1877505-9-aahringo@redhat.com>

On Wed, Aug 14, 2024 at 10:34:10AM -0400, Alexander Aring wrote:
> Currently there exists the kset_create_and_add() helper that does not
> allow to have a different ktype for the created kset kobject. To allow
> a different ktype this patch will introduce the function
> kset_type_create_and_add() that allows to set a different ktype instead
> of using the global default kset_ktype variable.
> 
> In my example I need to separate the created kobject inside the kset by
> net-namespaces. This patch allows me to do that by providing a user
> defined kobj_type structure that implements the necessary namespace
> functionality.
> 
> Signed-off-by: Alexander Aring <aahringo@redhat.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

