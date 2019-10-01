Return-Path: <linux-raid-owner@vger.kernel.org>
X-Original-To: lists+linux-raid@lfdr.de
Delivered-To: lists+linux-raid@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52E4EC415C
	for <lists+linux-raid@lfdr.de>; Tue,  1 Oct 2019 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbfJATzN (ORCPT <rfc822;lists+linux-raid@lfdr.de>);
        Tue, 1 Oct 2019 15:55:13 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52832 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfJATzN (ORCPT
        <rfc822;linux-raid@vger.kernel.org>); Tue, 1 Oct 2019 15:55:13 -0400
Received: by mail-wm1-f47.google.com with SMTP id r19so4695482wmh.2;
        Tue, 01 Oct 2019 12:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=nwRNMA2eLikCz1zJK0XdmznJ7Y7Tmf5uJTaHJhcWezQ=;
        b=salBv0FAv67M9Ax6By7B+zt715g0rAhZVrIwVrBP96FPUDxs7BgGExXzZkn6hu/LgC
         fBtR+aw5mfOM7GjWaluaqVjx3hb7Nt8rbYNURTcYGWKMQhwF7GYXaiI1s2MshUdzOhSH
         SGotPbK+RsXnQ4jQdANKWHXGTlDKGum6SNdZR0oRKPOGbV0NK2mbqOA0a5vYW3dfHfDq
         jQz+pNvCuMIMT6GYlgY8UjWrxLLJ36KllnxjG8jT5j30yWmYDf0mLxFIZVa5p8uRMSz3
         wU2jY9FDCcwl3gl5Eh80c60497JJzQ/UfecZb4WmKZCONxVbrsgk+1opws6IQWvYR+1X
         pK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=nwRNMA2eLikCz1zJK0XdmznJ7Y7Tmf5uJTaHJhcWezQ=;
        b=W2hfLMqYuu/RFxs6jTEmXYddvThEmfpO15IvOkm4A3S75gk1lKEi6BmmeYoqPziFPY
         1IoD85UTFlYaJV3eXV70+eoT57Gm4E3mzrH2+G/YHOjhsE7L5/qtt7tGY56I7iEj47/0
         iC9hXnYo93Ua+U7yLsuvrTL2pFW/Jjmp4H5y8a3h9vhdQTKKeYdqOX82qYHRS7qPsdGY
         E1mUsSvhet+6UoHRnSKuObVpcJsU7RjWooh7ntCFP37g5WErnEiykBEaE9jmoaQf2Qel
         ib3RERAMJPzFwq0SK3ZV+PhoOLTIxQSxjsyFgsW+KF7bjWcUBafShqdV4hZg5mDHtLTl
         FWGg==
X-Gm-Message-State: APjAAAWEoyi28Dk5b+ZAUi8zXkXpDyD/CyTKR2MQxFLZe0xHdcpzdiHS
        1DPpHG5YW6Id4FcBvKXLgIjGz7RHg4jKVPQFEitrgg==
X-Google-Smtp-Source: APXvYqxq0TH2Bw4dzxY4BiF8UGKwXp/nrsbR/YD+uNHPnH1qtzeS1vWL/yU9VJ6GwQ/HW5/AwFkUQbASaghNEb99SR0=
X-Received: by 2002:a1c:2d44:: with SMTP id t65mr5120969wmt.12.1569959709261;
 Tue, 01 Oct 2019 12:55:09 -0700 (PDT)
MIME-Version: 1.0
From:   "David F." <df7729@gmail.com>
Date:   Tue, 1 Oct 2019 12:54:58 -0700
Message-ID: <CAGRSmLsGS+j2kn7hMB8JC3HuWjj+3NpxcUN_PAnF-wWZAMC3kQ@mail.gmail.com>
Subject: Will Linux ever add support for new Intel storage controllers in RAID mode?
To:     linux-kernel <linux-kernel@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-raid-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-raid.vger.kernel.org>
X-Mailing-List: linux-raid@vger.kernel.org

Hi,

It's been quite a while now and haven't seen anything about Linux
adding support for these new Intel controllers in RAID mode.   Nothing
shows at all unless the controller is changed to AHCI mode.   The
manufactures are typically selling their systems with that controller
in RAID mode having NVMe m.2 devices with Windows.  So Linux can't be
used at all without changing things either temporarily for emergency
boot disks or altering windows as well to get Linux installed.

Someone said Intel provided a patch or firmware at some point, but
it's missing and nobody is talking about it?

Anyone?

TIA!!
