Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D72BC24DD
	for <lists+linux-raid@lfdr.de>; Mon, 30 Sep 2019 18:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732151AbfI3QHj (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Mon, 30 Sep 2019 12:07:39 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53342 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbfI3QHj (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Mon, 30 Sep 2019 12:07:39 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so92163wmd.3
        for <linux-raid@vger.kernel.org>; Mon, 30 Sep 2019 09:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cKYy/lgqB/Z0G2Ik1R8XIP6FqHmfzZWRsuRUEMFCHNw=;
        b=G3UZfXoBArFmN3ej174hw8NzCEP+T91V2kcMzSKH/XeyD4ZvhspkddnRp3ZQY+d3Xk
         NW/SdvOauuSSsmd3nhVvjaZGZ0Dd0eZFwJOwg7exeZTKmHp2preQ5A2C6qiI0O3Eq9uM
         k7MVwWUjyWhh/n606ojv3pyx+3vHlVsA7bC+LFZYsZLl1m+EvoiunHTHhVRK6ONyAsNK
         tQFGGXfKo2GbyqUjFeltwWs93kUS/YLT8lEvG7A5+wCALcnJRv6RLpJo512BtCVBnXFR
         1dmyWSVJ+9dhI/VkE2lebC0FlI0qcgGv6A/0OdxX10kt/S2Zdw7pRXny1Fjvxi0Lw1Nc
         VMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cKYy/lgqB/Z0G2Ik1R8XIP6FqHmfzZWRsuRUEMFCHNw=;
        b=aOC9lAEbtU32tLmLzrumJBZDqX1izaK36Z0Hgpl37HUSEfdYF+PoVDUT/zTOYBhW0r
         2F6mQEyesYNdgQfFkh9z/ksJWqxMbXzVzry3rI+jZ9EdfDIz4lUAHsRKqonX+mJG0D3b
         6Tv/r+AVp3Kr3VBTkFkeHrDFzodVMr3luGpfYZ6tym8HsiwxgfiGXnGsq4AyeKskkxyf
         GaTAp2rvckw1Yq2S5coiiiaDoDFLKIMjxM1JO9PK17FXpmldzNcr8sxh9Pu9GPv1k1Sm
         LuKSnx4R8bjU+obkNTEgdqTkNmLXPqRlTX9FiRxRdTBnGkVvn8CO2cs404ciLfAtdqBL
         rhqQ==
X-Gm-Message-State: APjAAAV4sOkigGTSdBjDOx8rUFD89hzEw4UIMmJ/cXRl4h9pmVOAtvoA
        LNK6vq2Y+naDxlhcz6ZTOmHBZZ5aDiFicLoqAic=
X-Google-Smtp-Source: APXvYqw0nQCZh2Jxmuhy7LKZjXy7dRKJ93X/wQOtcWfIDJ8wLyGdWI0Tb9lFRJZA3qotQNdMlv8U7ltMW1JS77Scc3g=
X-Received: by 2002:a1c:2d85:: with SMTP id t127mr18993840wmt.81.1569859655527;
 Mon, 30 Sep 2019 09:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAGRSmLs+nyQ0pp_VPt36MxXDqumcyqLSR_vhkOqtFXir18puEA@mail.gmail.com>
 <20190930101443.GA2751@metamorpher.de>
In-Reply-To: <20190930101443.GA2751@metamorpher.de>
From:   "David F." <df7729@gmail.com>
Date:   Mon, 30 Sep 2019 09:07:24 -0700
Message-ID: <CAGRSmLtpC_5HV9xfU+YHPEbCa+bMPTVCuGumK=4SmVm9pHODMg@mail.gmail.com>
Subject: Re: Fix for fd0 and sr0 in /proc/partitions
To:     Andreas Klauer <Andreas.Klauer@metamorpher.de>
Cc:     "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

One isn't defined, there is a mdadm.conf-default file but no actual
file, so using the default.

On Mon, Sep 30, 2019 at 3:14 AM Andreas Klauer
<Andreas.Klauer@metamorpher.de> wrote:
>
> On Sun, Sep 29, 2019 at 03:54:41PM -0700, David F. wrote:
> > So /proc/partitions can have floppy and optical drives on it.
>
> And people might rely on that so removing it is the wrong approach.
>
> What does your mdadm.conf look like, DEVICE devices?
>
> Regards
> Andreas Klauer
